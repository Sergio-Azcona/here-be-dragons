require 'rspec'
require 'pry'
require './lib/nytimes'

class Nytimes
  describe 'data' do 
    before :each do 
      @hash = Nytimes::DATA
    end 
  
    it 'can get status' do 
      #FINISHED EXAMPLE: Using @hash, define a variable called `result` that returns the status
      result = @hash[:status]
      
      expect(result).to eq("OK")
    end

    it 'can get copyright' do 
      #Using @hash, define a variable called `result` that returns the copyright
      result = @hash[:copyright]
      expect(result).to eq("Copyright (c) 2018 The New York Times Company. All Rights Reserved.")
    end

    it 'can get array of stories' do 
      #Using @hash, define a variable called `result` that returns the array of stories
      result = @hash[:results]
      expect(result).to be_an_instance_of(Array)
      expect(result.count).to eq(44)
    end

    it 'can get all stories with subsection of politics' do 
      #Using @hash, define a variable called `result` that returns all stories with subsection of politics.
      
      # require 'pry';binding.pry
      result = @hash[:results].select do |r|
       r[:subsection] == "Politics" 
      end
              
      expect(result).to be_an_instance_of(Array)
      expect(result.count).to eq(6)
      expect(result.first[:title]).to eq("Congressional G.O.P. Agenda Quietly Falls Into Place Even as Trump Steals the Spotlight")
      expect(result.last[:title]).to eq("Conspiracy Theories Made Alex Jones Very Rich. They May Bring Him Down.")
    end

    #practice
    it 'can get all titles which have Serena Williams as a subject' do       
      williams = []
      result = @hash[:results].select do |r|
        # require 'pry';binding.pry
        williams << r[:title] if r[:per_facet].include?("Williams, Serena")   
          end
              # require 'pry';binding.pry
      expect(result).to be_an_instance_of(Array)
      expect(result.count).to eq(2)
      expect(result.first[:item_type]).to eq("Article")
      expect(williams).to eq(["Serena Williams vs. Naomi Osaka: Clash of Generations With Common Threads", "Serena Williams. New Mom. Elite Athlete. Extraordinary and Ordinary All at Once."])
    end
  
  
    it "can get all Opinion section image url for superJumbo images" do       
      superjumbo_images = []
      opinion_result = @hash[:results].select do |r|
        if r[:section] == ("Opinion")   
          r[:multimedia].select do |m|
            superjumbo_images <<  m[:url] if m[:format] == ("superJumbo")
            # require 'pry';binding.pry
          end
        end
      end
    # require 'pry';binding.pry
    expect(opinion_result.count).to eq(5)
    expect(opinion_result.first[:section]).to eq("Opinion")
    expect(superjumbo_images.count).to eq(5)
    expect(superjumbo_images).to be_an_instance_of(Array)
    
    urls = ["https://static01.nyt.com/images/2018/09/09/opinion/sunday/09Samaha4/merlin_143376285_1627e23e-8c5d-4347-82e2-8df34cc76b16-superJumbo.jpg",
            "https://static01.nyt.com/images/2018/09/08/opinion/08Merkin1/08Merkin1-superJumbo.jpg",
            "https://static01.nyt.com/images/2018/09/07/opinion/07kavanaugh/merlin_143423172_ba667746-4fe5-414c-9258-aea84b05c0dc-superJumbo.jpg",
            "https://static01.nyt.com/images/2018/09/07/opinion/07mitchell/merlin_143420529_de5a9d6a-8dfc-4825-b492-5092ee3cfa7d-superJumbo.jpg",
            "https://static01.nyt.com/images/2018/09/07/opinion/07collinsWeb/07collinsWeb-superJumbo.jpg"
            ]
    expect(superjumbo_images).to eq(urls)
    end
  
  end 
end
