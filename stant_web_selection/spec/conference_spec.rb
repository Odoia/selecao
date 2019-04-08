require 'spec_helper'
require './lecture'

describe 'Organize lectures from a conference by txt file' do
  context 'when have a file with 19 lines' do
    
    lecture = Lecture.new
    it 'Show the correct size of array' do 
      expect(lecture.get_txt.size).to eq 19
    end 
  end

  context 'when need to separate the time of each lecture' do
    context 'when the lecture has the time' do
      
      string = 'Erros comuns em Ruby 45min'
      lecture = Lecture.new

      it 'show the minutes lecture' do
        expect(lecture.get_lecture_time(string)).to eq ["45"]
      end
    end

    context "when the lecture don't have the time" do
      context 'use a default value' do

        string = 'Rails para usuários de Django lightning'
        lecture = Lecture.new

        it 'show the default minutes(5min) to lecture' do
          expect(lecture.get_lecture_time(string)).to eq ["05"]
        end
      end
    end
  end

  context 'when need to populate an array with lecture and time' do
    context 'when have minutes in the array' do
      
      lecture = Lecture.new
      string_array = ['Erros comuns em Ruby 45min']

      it 'show correct string array and correct int minutes' do
       expect(lecture.get_speeches(string_array)).to eq [['Erros comuns em Ruby 45min', 45]]
      
      end
    end

    context "when don't have minutes in the array  " do
      
      lecture = Lecture.new
      string_array = ['Rails para usuários de Django lightning']

      it 'show correct string array and correct int minutes to default value' do
        expect(lecture.get_speeches(string_array)).to eq [['Rails para usuários de Django lightning', 05]]
      
      end
    end
  end

  context 'when need organize speeches by turns' do
    context 'when need a morning turn 180 minutes  ' do
      lecture = Lecture.new
      received_list = lecture.get_speeches(lecture.get_txt)
      received_list_copy = received_list.dup
      empty_array = []
      a = 0
      result = lecture.organize_speeches(empty_array, 180)
      result.each do |o|
        a += o[1]
      end
      
      it 'show a list of 180 minutes track' do
        expect(a).to eq 180
      end
    end

    context 'when need a afternoon turn 240 minutes  ' do
      lecture = Lecture.new
      received_list = lecture.get_speeches(lecture.get_txt)
      received_list_copy = received_list.dup
      empty_array = []
      a = 0
      result = lecture.organize_speeches(empty_array, 240)
      result.each do |o|
        a += o[1]
      end
      
      it 'show a list between 180 and 240 minutes track' do
        expect(a).to satisfy { |x| x >= 180 && x <= 240  }
      end
    end
  end
end 