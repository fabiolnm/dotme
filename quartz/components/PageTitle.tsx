import { pathToRoot } from "../util/path"
import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { classNames } from "../util/lang"

const PageTitle: QuartzComponent = ({ fileData, displayClass }: QuartzComponentProps) => {
  const baseDir = pathToRoot(fileData.slug!)
  return (
    <a href={baseDir} class={classNames(displayClass, "page-title")}>
      <img 
        src="https://raw.githubusercontent.com/fabiolnm/dotme/avatar/picture.png" 
        alt="Fabio Luiz"
        class="avatar"
      />
    </a>
  )
}

PageTitle.css = `
.page-title {
  margin: 0;
}
.page-title .avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  object-fit: cover;
  object-position: center 30%;
  box-shadow: 0 0 3px var(--gray);
}
`

export default (() => PageTitle) satisfies QuartzComponentConstructor
