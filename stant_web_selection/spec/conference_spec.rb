require 'spec_helper'
require './lecture'

describe 'Organize lectures from a conference by txt file' do

  let(:lecture) { Lecture.new }
  let(:execute_actions) {}

  before do
    lecture
    execute_actions
  end

  context 'when have a file with 19 lines' do

    it 'Show the correct size of array' do 
      expect(lecture.get_txt.size).to eq 19
    end 
  end

  context 'when need to separate the time of each lecture' do
    context 'when the lecture has the time' do
   
      title = 'Erros comuns em Ruby 45min'
      
      it 'show the minutes lecture' do
        expect(lecture.get_lecture_time(title)).to eq ["45"]
      end
    end

    context "when the lecture don't have the time" do
      context 'use a default value' do
        title = 'Rails para usuários de Django lightning'

        it 'show the default minutes(5min) to lecture' do
          expect(lecture.get_lecture_time(title)).to eq ["05"]
        end
      end
    end
  end

  context 'when need to populate an array with lecture and time' do
    context 'when have minutes in the array' do
      speeche = ['Erros comuns em Ruby 45min']

      it 'show correct string array and correct int minutes' do
       expect(lecture.get_speeches(speeche)).to eq [['Erros comuns em Ruby 45min', 45]]
      
      end
    end

    context "when don't have minutes in the array  " do
      speeche = ['Rails para usuários de Django lightning']

      it 'show correct string array and correct int minutes to default value' do
        expect(lecture.get_speeches(speeche)).to eq [['Rails para usuários de Django lightning', 05]]
      
      end
    end
  end

  context 'when need organize speeches by turns' do
    context 'when need a morning turn 180 minutes  ' do
      a = 0
      let(:execute_actions) do
        lecture.organize_speeches(180).each do |o|
          a += o[1]
        end
      end
      
      it 'show a list of 180 minutes track' do
        expect(a).to eq 180
      end
    end

    context 'when need a afternoon turn 240 minutes  ' do
      a = 0
      let(:execute_actions) do
        lecture.organize_speeches(240).each do |o|
          a += o[1]
        end
      end

      it 'show a list between 180 and 240 minutes track' do
        expect(a).to satisfy { |x| x >= 180 && x <= 240  }
      end
    end
  end
end 