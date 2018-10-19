RSpec.shared_examples 'k7_driver' do |verbs, emiter|
  describe 'event emission' do
    before do
      expect(K7).to receive(:emit_request)
      expect(K7).to receive(:emit_response)
    end
    verbs.each do |verb|
      it "verb #{verb}" do
        public_send(verb)
      end
    end
  end

  describe 'responses' do
    verbs.each do |verb|
      describe "Verb #{verb}" do
        let(:response) { public_send(verb); K7::Testing.last_response }
        [:status, :body, :headers].each do |meth|
          it "verb #{verb} response.#{meth} " do
            expect(response).to respond_to(meth)
          end
        end

        describe 'emiter' do
          it { expect(response.emiter).to be >= emiter }
        end

        describe 'status' do
          it { expect(response.status).to be >= 200 }
          it { expect(response.status).to be < 600 }
        end

        describe 'body' do
          it { expect(response.body).to be_instance_of String }
        end

        describe 'headers' do
          it { expect(response.headers).to be_instance_of Hash }
          xit { expect(response.headers.fetch('content-type')).to eq 'application/json; charset=utf-8' }
        end
      end
    end
  end

  describe 'request' do
    verbs.each do |verb|
      describe "Verb #{verb}" do
        let(:request) { public_send(verb); K7::Testing.last_request }
        [:query_params, :params, :body, :uri, :headers, :verb].each do |meth|
          it "verb #{verb} request.#{meth} " do
            expect(request).to respond_to(meth)
          end
        end

        it do
          expect(request.verb).to eq verb.to_s
        end

        describe 'post body'
        describe 'body' do
          it { expect(request.body).to be_instance_of String }
        end

        describe 'headers' do
          it { expect(request.headers).to be_instance_of Hash }
          xit { expect(request.headers.fetch('content-type')).to eq 'application/json; charset=utf-8' }
        end
      end
    end
  end
end
