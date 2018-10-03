# frozen_string_literal: true

require('./models/top_stories')
require('./models/story')
require('./models/formatted_story')
require('./models/response_validation')
require('./models/input_validation')
require('./processors/top_stories_request_processor')

TopStoriesRequestProcessor.new.execute
