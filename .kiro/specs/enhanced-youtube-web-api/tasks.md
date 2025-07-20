# Implementation Plan

- [ ] 1. Enhance YouTube handler with new request/response structures
  - Create new request structs (MetadataRequest, CommentsRequest, ExtractRequest, PlaylistRequest) in youtube.go
  - Create new response structs (MetadataResponse, CommentsResponse, ExtractResponse, PlaylistResponse) with proper JSON tags
  - Add ErrorResponse struct for consistent error handling across all endpoints
  - _Requirements: 1.1, 2.1, 3.1, 4.1, 5.1_

- [ ] 2. Implement metadata extraction endpoint
  - Add POST /youtube/metadata route to YouTubeHandler
  - Implement Metadata method that validates request and calls existing GrabMetadata service
  - Transform VideoMetadata from service to MetadataResponse format
  - Add proper error handling for invalid URLs and missing API keys
  - _Requirements: 1.1, 1.2, 1.3_

- [ ] 3. Implement comments extraction endpoint
  - Add POST /youtube/comments route to YouTubeHandler
  - Implement Comments method that validates request and calls existing GrabComments service
  - Transform comment strings to Comment struct format with proper parsing
  - Add maxResults parameter validation (default 100, max 100)
  - Handle cases where comments are disabled or unavailable
  - _Requirements: 2.1, 2.2, 2.3, 2.4_

- [ ] 4. Implement comprehensive extract endpoint
  - Add POST /youtube/extract route to YouTubeHandler
  - Implement Extract method that conditionally calls multiple service methods based on request flags
  - Aggregate results from transcript, comments, and metadata services into single response
  - Implement partial success handling - return available data even if some components fail
  - Add error collection for failed components in response.Errors array
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5_

- [ ] 5. Implement playlist processing endpoint
  - Add POST /youtube/playlist route to YouTubeHandler
  - Implement Playlist method that validates playlist URLs and calls FetchPlaylistVideos service
  - Add pagination support with offset and limit parameters (default limit 50, max 100)
  - Conditionally include transcript data for each video when includeTranscripts flag is true
  - Handle private/unavailable playlists with appropriate error responses
  - _Requirements: 5.1, 5.2, 5.3, 5.4_

- [ ] 6. Add comprehensive error handling and validation
  - Create validateRequest helper method for JSON binding and URL validation
  - Implement specific error codes and messages for different failure scenarios
  - Add URL format validation with regex patterns for YouTube URLs
  - Create helper methods for consistent error response formatting
  - Add validation for parameter ranges (maxResults, offset, limit)
  - _Requirements: 4.1, 4.2, 4.3, 4.4_

- [ ] 7. Implement CORS support for web applications
  - Add OPTIONS handler for all YouTube endpoints to support preflight requests
  - Implement setupCORS helper method to set appropriate headers
  - Add CORS headers to all response methods (GET, POST, OPTIONS)
  - Configure Access-Control-Allow-Origin, Methods, and Headers appropriately
  - _Requirements: 6.1, 6.2, 6.3, 6.4_

- [ ] 8. Add comprehensive unit tests for new endpoints
  - Write tests for request validation logic in all new endpoint methods
  - Test URL parsing and video/playlist ID extraction functionality
  - Test response formatting and JSON serialization for all response types
  - Test error handling scenarios including malformed requests and service failures
  - Mock YouTube service calls to test handler logic independently
  - _Requirements: All requirements - testing coverage_

- [ ] 9. Add integration tests for end-to-end functionality
  - Write integration tests that call actual endpoints with test data
  - Test CORS functionality with preflight and actual requests
  - Test error response consistency across all endpoints
  - Verify proper HTTP status codes for different scenarios
  - Test with real YouTube URLs (using test videos) to ensure service integration works
  - _Requirements: All requirements - integration testing_

- [ ] 10. Configure Railway deployment setup
  - Create railway.json configuration file for deployment settings
  - Add Dockerfile optimizations for Railway platform (if needed)
  - Configure environment variables for Railway (YOUTUBE_API_KEY, PORT, etc.)
  - Add railway.toml for service configuration and build settings
  - Test deployment process and verify API endpoints work on Railway
  - _Requirements: All requirements - deployment infrastructure_

- [ ] 11. Update API documentation and examples
  - Add new endpoint documentation to README or API docs
  - Create example requests and responses for each new endpoint
  - Document error codes and their meanings
  - Add setup instructions for YouTube API key configuration
  - Create JavaScript/curl examples for web developers
  - Document Railway deployment process and environment setup
  - _Requirements: 1.3, 2.4, 4.1, 6.4_