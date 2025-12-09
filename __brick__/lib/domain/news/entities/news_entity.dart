{{#include_example_feature}}
/// News Entity - Domain layer (Pure Dart, no Flutter dependencies)
/// 
/// Represents a news article with all its metadata from NewsData.io API.
/// This is a domain entity - it contains no external dependencies and
/// represents the core business object.
class NewsEntity {
  final String? articleId;
  final String? title;
  final String? link;
  final List<String>? keywords;
  final List<String>? creator;
  final String? videoUrl;
  final String? description;
  final String? content;
  final String? pubDate;
  final String? pubDateTZ;
  final String? imageUrl;
  final String? sourceId;
  final int? sourcePriority;
  final String? sourceName;
  final String? sourceUrl;
  final String? sourceIcon;
  final String? language;
  final List<String>? country;
  final List<String>? category;
  final String? aiTag;
  final String? sentiment;
  final String? sentimentStats;
  final String? aiRegion;
  final String? aiOrg;
  final bool? duplicate;

  const NewsEntity({
    this.articleId,
    this.title,
    this.link,
    this.keywords,
    this.creator,
    this.videoUrl,
    this.description,
    this.content,
    this.pubDate,
    this.pubDateTZ,
    this.imageUrl,
    this.sourceId,
    this.sourcePriority,
    this.sourceName,
    this.sourceUrl,
    this.sourceIcon,
    this.language,
    this.country,
    this.category,
    this.aiTag,
    this.sentiment,
    this.sentimentStats,
    this.aiRegion,
    this.aiOrg,
    this.duplicate,
  });

  /// Copy with method for immutability
  NewsEntity copyWith({
    String? articleId,
    String? title,
    String? link,
    List<String>? keywords,
    List<String>? creator,
    String? videoUrl,
    String? description,
    String? content,
    String? pubDate,
    String? pubDateTZ,
    String? imageUrl,
    String? sourceId,
    int? sourcePriority,
    String? sourceName,
    String? sourceUrl,
    String? sourceIcon,
    String? language,
    List<String>? country,
    List<String>? category,
    String? aiTag,
    String? sentiment,
    String? sentimentStats,
    String? aiRegion,
    String? aiOrg,
    bool? duplicate,
  }) {
    return NewsEntity(
      articleId: articleId ?? this.articleId,
      title: title ?? this.title,
      link: link ?? this.link,
      keywords: keywords ?? this.keywords,
      creator: creator ?? this.creator,
      videoUrl: videoUrl ?? this.videoUrl,
      description: description ?? this.description,
      content: content ?? this.content,
      pubDate: pubDate ?? this.pubDate,
      pubDateTZ: pubDateTZ ?? this.pubDateTZ,
      imageUrl: imageUrl ?? this.imageUrl,
      sourceId: sourceId ?? this.sourceId,
      sourcePriority: sourcePriority ?? this.sourcePriority,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      sourceIcon: sourceIcon ?? this.sourceIcon,
      language: language ?? this.language,
      country: country ?? this.country,
      category: category ?? this.category,
      aiTag: aiTag ?? this.aiTag,
      sentiment: sentiment ?? this.sentiment,
      sentimentStats: sentimentStats ?? this.sentimentStats,
      aiRegion: aiRegion ?? this.aiRegion,
      aiOrg: aiOrg ?? this.aiOrg,
      duplicate: duplicate ?? this.duplicate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NewsEntity && other.articleId == articleId;
  }

  @override
  int get hashCode => articleId.hashCode;

  @override
  String toString() => 'NewsEntity(id: $articleId, title: $title)';
}
{{/include_example_feature}}
