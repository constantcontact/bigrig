describe LogAction do
  describe '#perform' do
    subject { described_class.new(file).perform }
    let(:file) { test_file 'log.json' }
    let(:image) { Docker::Image.create 'fromImage' => 'hawknewton/log-test:0.0.1' }
    let(:container) { Docker::Container.get 'log-test' }

    before do
      Docker::Container.create('Image' => image.id, 'name' => 'log-test').start
    end

    after do
      container.kill.delete
    end

    it 'follows the log', :vcr do
      allow(Docker::Container).to receive(:get).with('log-test').and_return container
      allow(container).to receive(:streaming_logs).
        and_yield('stdout', 'stdout message').
        and_yield('stderr', 'stderr message')
      expect($stdout).to receive(:puts).with 'stdout: stdout message'
      expect($stdout).to receive(:puts).with 'stderr: stderr message'
      subject
    end
  end
end
