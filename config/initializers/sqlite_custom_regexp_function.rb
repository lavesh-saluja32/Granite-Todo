# frozen_string_literal: true

# # frozen_string_literal: true

# ActiveSupport.on_load(:active_record) do
#   ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do
#     alias_method :orig_initialize, :initialize

#     def initialize(connection, logger = nil, pool = nil)
#       orig_initialize(connection, logger, pool)

#       is_sqlite_db = ActiveRecord::Base.connection_db_config.configuration_hash[:adapter] == "sqlite3"

#       if is_sqlite_db && connection.respond_to?(:create_function)
#         # connection.create_function("regexp", 2) do |fn, pattern, expr|
#         #   regex_matcher = Regexp.new(pattern.to_s, Regexp::IGNORECASE)
#         #   fn.result = expr.to_s.match(regex_matcher) ? 1 : 0
#         # end
#         db = ActiveRecord::Base.connection.raw_connection
#         db.create_function("regexp", 2) do |func, pattern, expression|
#           func.result = expression.to_s.match(Regexp.new(pattern.to_s, Regexp::IGNORECASE)) ? 1 : 0
#         end
#       end
#     end
#   end
# end
