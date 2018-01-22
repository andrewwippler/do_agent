require 'spec_helper'

describe 'do_agent' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts.merge('dmi' => { 'manufacturer' => 'DigitalOcean' }) }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_package('do-agent').with(ensure: 'present') }
    end

    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.not_to compile }
    end
  end

  context 'Ubuntu broken' do
    let(:facts) { { 'dmi' => { 'manufacturer' => 'DigitalOcean' }, 'os' => { 'release' => { 'full' => '13.10', 'major' => '8' } } } }

    it { is_expected.not_to compile }
  end

  context 'Fedora broken' do
    let(:facts) { { 'dmi' => { 'manufacturer' => 'DigitalOcean' }, 'os' => { 'release' => { 'major' => '24' } } } }

    it { is_expected.not_to compile }
  end

  context 'CentOS broken' do
    let(:facts) { { 'dmi' => { 'manufacturer' => 'DigitalOcean' }, 'os' => { 'release' => { 'major' => '5' } } } }

    it { is_expected.not_to compile }
  end
end
