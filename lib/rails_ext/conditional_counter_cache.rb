module ConditionalCounterCache
  private
    def normalize_options(options)
      counter_cache = options[:counter_cache]

      if counter_cache
        super.deep_merge(counter_cache: { if: counter_cache[:if] })
      else
        super
      end
    end
end

module ConditionalCounterCacheCheck
  private
    def require_counter_update?
      super && counter_cacheable?
    end

    def counter_cacheable?
      if counter_cache_if.present?
        owner.send(counter_cache_if)
      else
        true
      end
    end

    def counter_cache_if
      options.fetch(:counter_cache, {})[:if]
    end
end

ActiveRecord::Reflection::MacroReflection.prepend ConditionalCounterCache
ActiveRecord::Associations::BelongsToAssociation.prepend ConditionalCounterCacheCheck
