import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

export const sharedPageComponents: SharedLayout = {
  head: Component.Head(),
  header: [
    Component.PageTitle(),
    Component.Spacer(),
    Component.SocialLinks(),
    Component.Search(),
    Component.Darkmode(),
  ],
  afterBody: [
    Component.RecentNotes({
      title: " ",
      limit: 10,
      showTags: true,
      linkToMore: "entries/" as any,
      filter: (f) => f.slug !== "index",
    }),
  ],
  footer: Component.Footer({
    links: {},
  }),
}

export const defaultContentPageLayout: PageLayout = {
  beforeBody: [
    Component.ConditionalRender({
      component: Component.Breadcrumbs(),
      condition: (page) => page.fileData.slug !== "index",
    }),
    Component.ArticleTitle(),
    Component.ConditionalRender({
      component: Component.ContentMeta(),
      condition: (page) => page.fileData.slug !== "index",
    }),
    Component.TagList(),
  ],
  left: [],
  right: [],
}

export const defaultListPageLayout: PageLayout = {
  beforeBody: [Component.Breadcrumbs(), Component.ArticleTitle(), Component.ContentMeta()],
  left: [],
  right: [],
}
