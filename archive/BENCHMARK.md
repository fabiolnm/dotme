# Dotfile and Development Environment Management Tools Benchmark

## Executive Summary

This benchmark evaluates dotme against development environment management tools, analyzing which tools truly compete with dotme's complete value proposition: git-based versioning of multi-tool preferences, tool installation management, profile switching, and easy sharing via git clone.

**Multi-Model Consensus Finding (Gemini-2.5-pro + GPT-5-pro):** Only 4 tools match dotme's complete feature set: chezmoi, yadm, nix/home-manager, and dotdrop. dotme's unique position is not in having unique features, but in being a minimalist orchestrator that prioritizes transparency and simplicity over built-in complexity.

**Critical Clarification:** Many tools in this benchmark (Stow, rcm, mise, asdf, etc.) do NOT compete with dotme's core value proposition. They solve partial problems (dotfiles-only or tool-management-only) and are included for educational context about the broader ecosystem.

---

## 1. Tool Categories

### 1.1 Complete Competitors
Tools that match ALL of dotme's core features: git-based multi-tool preference versioning, tool installation, profile switching, and easy sharing.

**TRUE COMPETITORS:**
- chezmoi
- yadm
- nix / home-manager
- dotdrop

### 1.2 Partial Solutions - Dotfile Management Only
Tools that manage configuration files but do NOT handle tool installation.

**EDUCATIONAL REFERENCES (Not Direct Competitors):**
- GNU Stow
- rcm
- homesick
- dotbot (lacks native profile switching)
- mackup
- Bare Git Repository Method

### 1.3 Partial Solutions - Tool Management Only
Tools that manage tool installation but do NOT handle multi-tool preferences/dotfiles.

**COMPLEMENTARY TOOLS (Not Competitors):**
- mise (dotme integrates with mise)
- asdf
- devbox
- direnv

### 1.4 Single-Application Tools
Specialized tools for managing single IDE settings via account sync, not git.

**EXCLUDED (Different Use Case):**
- VS Code Settings Sync
- JetBrains IDE Settings Sync

---

## 2. Consensus Analysis: True Competitors

This section summarizes findings from multi-model analysis (Gemini-2.5-pro + GPT-5-pro) evaluating which tools actually match dotme's complete value proposition.

### 2.1 Complete Feature Match Criteria

To be considered a true competitor, a tool must provide ALL of these capabilities:
1. **Git-based versioning** of multi-tool preferences in one repository
2. **Tool installation management** (not just configuration)
3. **Profile switching** (native support, not manual config swapping)
4. **Easy sharing** of complete setups via git clone

### 2.2 The 4 True Competitors

#### chezmoi - Strongest Direct Competitor
**Why it matches:** Git-based, `run_` scripts for tool installation, powerful templating for profile switching
**Key advantage:** Stateful management + built-in secret management (age encryption, 1Password integration)
**Trade-off vs dotme:** Moderate complexity vs dotme's minimalist approach
**Adoption:** ~11.5k GitHub stars

#### yadm - Git-Native Alternative
**Why it matches:** Bare git repository wrapper, bootstrap scripts for tool installation, alternate file paths for profiles
**Key advantage:** Minimal learning curve for Git users, built-in GPG encryption
**Trade-off vs dotme:** Similar simplicity philosophy, different execution style
**Adoption:** ~4.6k GitHub stars

#### nix/home-manager - Maximum Reproducibility
**Why it matches:** Declarative packages + dotfiles management, excellent profile switching, git-based with flakes
**Key advantage:** Unmatched bit-for-bit reproducibility
**Trade-off vs dotme:** Steep learning curve and high complexity
**Adoption:** nix ~10.4k, home-manager ~5.7k GitHub stars

#### dotdrop - Declarative YAML Approach
**Why it matches:** Template-based YAML config, shell commands for tool installation, built-in profile switching
**Key advantage:** Powerful Jinja2 templating, declarative specification
**Trade-off vs dotme:** Moderate complexity, Python dependency
**Adoption:** ~1.7k GitHub stars

### 2.3 Why Other Tools Don't Match

#### Partial Match - dotbot
**Missing:** Native profile switching
**Has:** Tool installation via shell commands, git-based, declarative YAML
**Verdict:** Almost there, but profile switching requires manual separate configs

#### Dotfiles-Only Tools (Excluded)
**GNU Stow, rcm, homesick, mackup, Bare Git Method**
**Missing:** Tool installation management
**Why excluded:** Only solve half the problem (dotfiles but not tools)
**Value:** Educational references for symlink-based approaches

#### Tool-Management-Only (Excluded)
**mise, asdf, devbox, direnv**
**Missing:** Multi-tool preference/dotfile management
**Why excluded:** Install tools but don't manage their configurations
**Value:** Complementary tools (dotme integrates mise, not competes with it)

#### Single-Application Tools (Excluded)
**VS Code Settings Sync, JetBrains IDE Settings Sync**
**Missing:** Multi-tool support, git-based versioning
**Why excluded:** Only sync single IDE via account, not multi-tool git-based management

### 2.4 dotme's Unique Position

**Consensus Statement:** dotme is NOT unique in features, but IS unique in approach.

**What makes dotme different:**
- **Minimalist orchestrator** - ~50 LOC core vs feature-rich frameworks
- **Delegates complexity** - User scripts + mise integration vs built-in implementations
- **"No magic" philosophy** - Transparent shell scripts vs stateful/declarative systems
- **Formalizes pattern** - Structured setup scripts without imposing framework
- **Low maintenance** core with maximum flexibility

**Industry trend:** Movement from simple symlink managers (Stow) toward comprehensive lifecycle management (chezmoi, nix). dotme aligns with this trend through mise integration but maintains minimalist philosophy.

---

## 3. Detailed Tool Analysis

### 3.1 Complete Competitors - Detailed Analysis

#### chezmoi

**Primary Approach:** Template-based state management. Generates config files from templates using Go's `text/template` engine and stores target state in local database.

**Plugin/Extensibility:** No formal plugin system, but highly extensible via:
- Advanced templating logic
- `run_` scripts executed on `chezmoi apply`
- Integration with password managers (1Password, LastPass)
- `age` encryption support

**Tool Installation:** Via `run_` script mechanism (e.g., `run_once_install-packages.sh`).

**Profile Switching:** Excellent support via templating with conditionals based on OS, architecture, hostname, username, or custom variables.

**Implementation Complexity:** Go. Single static binary.

**Dependencies:** None beyond Git for versioning.

**Development Status:** Very active. One of the most feature-rich modern tools.

**Key Differentiator:** Stateful and idempotent operation. Knows the state of every managed file. Integrated secret management.

**Popularity:** ~11.5k GitHub stars

---

#### yadm

**Primary Approach:** Git-based. Wrapper around a bare Git repository in `$HOME`. Use `yadm` as proxy for git commands.

**Plugin/Extensibility:** Shell scripts via "bootstrap" feature to run after cloning.

**Tool Installation:** Handled via bootstrap script.

**Profile Switching:** Yes. Supports alternate file paths based on OS, hostname, user with simple templating.

**Implementation Complexity:** POSIX-compliant shell script.

**Dependencies:** `git` and standard Unix utilities.

**Development Status:** Active.

**Key Differentiator:** Minimal learning curve for Git users. Feels like using Git directly on home directory. Built-in symmetric encryption using `gpg`.

**Popularity:** ~4.6k GitHub stars

---

#### rcm

**Primary Approach:** Symlink-based, similar to Stow but with more conventions and helper features.

**Plugin/Extensibility:** No plugin system. Configuration via `rcrc` file.

**Tool Installation:** Not handled.

**Profile Switching:** Yes, via "tags" (`rcup -t work`).

**Implementation Complexity:** C with shell script wrappers.

**Dependencies:** Standard C library.

**Development Status:** Maintenance mode, core functionality stable.

**Key Differentiator:** More opinionated than Stow. Introduces tags, host-specific configs, and hooks (`pre-up`/`post-up`).

**Popularity:** ~2.9k GitHub stars

---

#### homesick

**Primary Approach:** Git-based wrapper. Treats dotfile repos ("castles") as Git repositories and symlinks contents into `$HOME`.

**Plugin/Extensibility:** No plugin system.

**Tool Installation:** Not handled.

**Implementation Complexity:** Ruby.

**Dependencies:** Ruby and `git`.

**Development Status:** Archived/unmaintained.

**Key Differentiator:** Early popularizer of "dotfiles in git repo" pattern with friendly CLI. "Castles" metaphor.

**Popularity:** ~2.1k GitHub stars

---

#### dotbot

**Primary Approach:** Configuration-driven. Define desired state (symlinks, directories, shell commands) in YAML file (`install.conf.yaml`).

**Plugin/Extensibility:** Yes, via plugins. Custom action handlers in Python.

**Tool Installation:** Via `shell` command directive in YAML.

**Profile Switching:** Not natively. Common pattern is separate YAML configs (`install-work.conf.yaml`).

**Implementation Complexity:** Python. Designed to bootstrap with minimal dependencies.

**Dependencies:** Python (standard library only) and `git`.

**Development Status:** Active.

**Key Differentiator:** Git submodule design. Installation is self-contained. Declarative with no dependencies beyond Python and Git.

**Popularity:** ~6.9k GitHub stars

---

#### Bare Git Repository Method

**Primary Approach:** Pure Git. Uses bare Git repository with custom alias (`alias dotgit='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`) to version control files directly in home directory.

**Plugin/Extensibility:** None. Extensibility from Git hooks and shell scripting.

**Tool Installation:** Not handled.

**Profile Switching:** Difficult. Separate branches can lead to complex merge conflicts.

**Implementation Complexity:** N/A (technique, not tool).

**Dependencies:** `git`.

**Development Status:** N/A.

**Key Differentiator:** Most raw method. Zero dependencies beyond Git. Conceptually simple for those understanding Git's `--git-dir` and `--work-tree`.

**Popularity:** N/A

---

### 2.2 Development Environment Managers

#### mise (formerly rtx)

**Primary Approach:** Shim-based. Places shims in `PATH` that intercept tool calls and redirect to correct version based on `.tool-versions` or `.mise.toml`.

**Plugin/Extensibility:** Yes. Own plugin system plus full compatibility with asdf plugins.

**Tool Installation:** Manages download, compilation, and installation via plugin system.

**Profile Switching:** Excellent. Named profiles in `.mise.toml` (e.g., `[profiles.test]`). Environment-variable-based activation.

**Implementation Complexity:** Rust. Single static binary.

**Dependencies:** None for tool itself. `git` and build tools may be required by plugins.

**Development Status:** Very active.

**Key Differentiator:** Performance and ergonomics. Significantly faster than asdf (Rust vs shell). TOML configuration more powerful than `.tool-versions`. Built-in profile management.

**Popularity:** ~6.3k GitHub stars

---

#### asdf

**Primary Approach:** Shim-based. Originator of pattern that mise adopted.

**Plugin/Extensibility:** Entire system built on massive community plugin ecosystem.

**Tool Installation:** Handled entirely by plugins.

**Profile Switching:** No native support. Achieved via `direnv` integration or manual `.tool-versions` swapping.

**Implementation Complexity:** POSIX-compliant shell script.

**Dependencies:** `bash`, `curl`, `git`, standard Unix utilities.

**Development Status:** Active and widely adopted.

**Key Differentiator:** Vast and mature plugin ecosystem. De facto standard in this space.

**Popularity:** ~20.3k GitHub stars

---

#### devbox

**Primary Approach:** Nix-based with user-friendly wrapper. `devbox.json` defines packages. `devbox shell` creates isolated, reproducible environment.

**Plugin/Extensibility:** Custom Nix flakes.

**Tool Installation:** Leverages Nixpkgs repository for pre-compiled binaries or source builds.

**Profile Switching:** Yes, multiple `devbox.json` configurations.

**Implementation Complexity:** Go with Nix backend.

**Dependencies:** None. Downloads own Nix dependency.

**Development Status:** Very active.

**Key Differentiator:** Reproducibility without steep Nix learning curve. Dockerfile-like user experience with Nix power. Project-specific by default.

**Popularity:** ~7.1k GitHub stars

---

#### nix / home-manager

**Primary Approach:** Declarative and functional package management.
- **Nix:** Package manager and language. Builds packages in isolation, composes environments by manipulating `PATH`.
- **home-manager:** Nix-based tool for declaratively managing user environment (dotfiles, services, packages).

**Plugin/Extensibility:** Entire Nix ecosystem (`Nixpkgs`, `flakes`). Most extensible but requires learning Nix language.

**Tool Installation:** Declarative. Specify packages in configuration file.

**Profile Switching:** Excellent. Different shell environments (`nix develop`) or `home-manager` configurations from same codebase.

**Implementation Complexity:** C++, Perl, and Nix language. Vast and complex ecosystem.

**Dependencies:** Nix package manager.

**Development Status:** Very active.

**Key Differentiator:** Unmatched reproducibility and purity. Guarantees bit-for-bit identical environment. Steep learning curve.

**Popularity:** nix ~10.4k, home-manager ~5.7k GitHub stars

---

#### direnv

**Primary Approach:** Environment variable loader. Loads environment variables from `.envrc` when entering directory, unloads when exiting.

**Plugin/Extensibility:** Shell functions in `.envrc` (bash script). Standard library functions (e.g., `layout python`).

**Tool Installation:** Not handled. Designed to activate tools installed by other managers.

**Profile Switching:** Core purpose. Each directory is its own profile.

**Implementation Complexity:** Go with shell integration.

**Dependencies:** None.

**Development Status:** Active.

**Key Differentiator:** Lightweight, project-specific environment activator. Composes with other tools (canonical: `asdf` + `direnv` or `nix` + `direnv`).

**Popularity:** ~11.8k GitHub stars

---

### 2.3 IDE/Tool Configuration Managers

#### mackup

**Primary Approach:** Symlink-based with application-awareness. Database of configuration file locations for hundreds of applications (especially macOS).

**Plugin/Extensibility:** Add custom application configurations.

**Tool Installation:** Not handled.

**Profile Switching:** No native support.

**Implementation Complexity:** Python.

**Dependencies:** Python.

**Development Status:** Maintenance mode.

**Key Differentiator:** Large built-in library of application configs. Just tell mackup to back up `vscode` and it knows where to look.

**Popularity:** ~4.9k GitHub stars

---

#### dotdrop

**Primary Approach:** Template-based, YAML-driven configuration. Similar to Dotbot with more advanced features.

**Plugin/Extensibility:** Custom actions and hooks.

**Tool Installation:** Can run shell commands to trigger installers.

**Profile Switching:** Yes, via profiles in YAML config.

**Implementation Complexity:** Python.

**Dependencies:** Python, `PyYAML`.

**Development Status:** Active.

**Key Differentiator:** Powerful declarative YAML configuration and Jinja2 templating. Similar to chezmoi but different syntax/philosophy.

**Popularity:** ~1.7k GitHub stars

---

#### VS Code Settings Sync

**Primary Approach:** Built-in feature syncing settings, extensions, keybindings, UI state to Microsoft/GitHub account.

**Key Differentiator:** Seamless and built-in. Path of least resistance for VS Code users. Only manages VS Code, not surrounding environment.

---

#### JetBrains IDE Settings Sync

**Primary Approach:** Bundled plugin syncing settings across JetBrains IDEs using JetBrains account.

**Key Differentiator:** Official integrated solution. Works across entire JetBrains product family.

---

## 3. Comprehensive Comparison Table

| Tool | Approach | Plugin System | Profile Switching | Dependencies | Complexity | Key Differentiator |
|------|----------|---------------|-------------------|--------------|------------|-------------------|
| **dotme** | Symlink + Plugin Orchestrator | Yes (bash scripts) | Yes (directory-based) | bash, mise | Simple (~50 LOC core) | Minimalist orchestrator with persona concept |
| **GNU Stow** | Symlink | No | Yes (subdirs) | Perl | Simple | Unix philosophy, transparent |
| **chezmoi** | Template + State | Extensive | Yes (templating) | None | Moderate | Stateful, secret management |
| **yadm** | Git wrapper | Bootstrap scripts | Yes (alternate files) | git | Moderate | Git familiarity, built-in encryption |
| **rcm** | Symlink | No | Yes (tags) | C stdlib | Simple | Opinionated Stow |
| **dotbot** | Declarative YAML | Yes (Python) | Manual configs | Python, git | Simple | Self-contained, declarative |
| **mise** | Shim-based | Yes (asdf-compatible) | Yes (profiles) | None | Moderate | Performance, modern ergonomics |
| **asdf** | Shim-based | Yes (massive ecosystem) | Via direnv | bash, curl, git | Moderate | Largest plugin ecosystem |
| **devbox** | Nix-based | Nix flakes | Yes | None | Moderate | Nix power, simple UX |
| **nix/home-manager** | Declarative functional | Nix ecosystem | Yes | Nix | Complex | Unmatched reproducibility |
| **direnv** | Environment loader | Shell functions | Yes (per-dir) | None | Simple | Lightweight activator |
| **mackup** | Symlink | Custom apps | No | Python | Simple | Application database |
| **dotdrop** | Template YAML | Actions/hooks | Yes | Python, PyYAML | Moderate | Jinja2 templating |

---

## 4. dotme Analysis

### 4.1 Complexity Comparison

**dotme's ~50 line core represents the orchestrator**, not the entire system. True complexity lives in user-created plugins.

#### vs. Compiled Tools (chezmoi, mise, devbox)
- **Simpler:** Core logic readable in single sitting
- **Trade-off:** Lacks robustness, error handling, cross-platform compatibility of compiled binaries
- **Advantage:** No complex state management, templating engine, or abstract syntax

#### vs. Interpreted Tools (dotbot, mackup)
- **Simpler:** Fewer dependencies (no Python runtime, PyYAML)
- **More direct:** Less abstracted than dotbot's Python plugin handlers

#### vs. Shell-based Tools (yadm, asdf)
- **Significantly simpler:** yadm and asdf contain thousands of lines for numerous commands
- **Different paradigm:** dotme is lightweight dispatcher, not feature-rich application

#### vs. Symlink Managers (Stow, rcm)
- **More readable:** bash vs Perl (Stow) or C (rcm)
- **Modern dependencies:** bash more common than Perl
- **Plugin-first:** Makes extensibility first-class vs layered on top

### 4.2 Feature Coverage

| Feature | dotme Approach | Comparison |
|---------|----------------|------------|
| **Dotfile Management** | Symlink-based | **Equivalent** to Stow, rcm, homesick. **Simpler** than chezmoi's stateful management. |
| **Tool Installation** | **Delegated** to mise | **Opinionated choice.** Unlike asdf/mise themselves, doesn't manage tools but orchestrates the tool that does. |
| **Profile Switching** | Directory-based (`.me`, `.me.mario`) | **Similar** to Stow subdirectories. **Less powerful** than chezmoi templating. More transparent but less dynamic. |
| **Templating** | **Excluded** (separate files per profile) | **Major trade-off.** chezmoi/dotdrop superior for minor variations. dotme requires file duplication. |
| **Encryption/Secrets** | **Excluded** (external: git-crypt, Vault) | **Inferior** to chezmoi's secret manager integration and yadm's GPG encryption. Significant gap. |
| **Declarative vs Imperative** | **Purely Imperative** (scripts run scripts) | **Different paradigm.** dotbot/nix are declarative. For users preferring imperative scripting. |
| **Idempotency** | **Partially supported** (symlinking yes, backups no) | Plugin-dependent. chezmoi offers stronger guarantees. |

### 4.3 Use Case Fit

#### Superior Use Cases
1. **Experienced shell scripters** wanting minimal framework for structured setup scripts
2. **Developers standardized on mise** wanting first-class tool integration
3. **Transparency advocates** valuing "no magic" systems they can fully understand and modify

#### Equivalent Use Cases
1. **Direct Stow replacement** for those preferring bash over Perl with explicit plugin model
2. **Small machine count** with distinctly different roles (personal vs work) without subtle overlapping variations

#### Inferior Use Cases
1. **Large heterogeneous fleets** requiring templating based on OS/hostname/architecture (chezmoi wins)
2. **Secret management requirements** for API keys/tokens within dotfile repo
3. **Junior developer onboarding** where declarative config (dotbot) preferred over imperative scripts
4. **Bit-for-bit reproducibility** requirements (nix/home-manager unmatched)

### 4.4 Unique Value Proposition

#### 1. Orchestration, Not Implementation
- Core value: provides discoverable convention (`plugins/*.sh`) for running scripts
- Feels like structured personal runbooks vs monolithic tool

#### 2. Persona/Avatar Concept
- Naming convention (`.me.mario`, `./itsame`) reframes environment management
- "Adopting a persona" more intuitive than abstract "profiles" or "tags"

#### 3. Opinionated mise Integration
- Avoids reinventing wheel by integrating best-in-class tool
- Differentiates from tools with no tool management or custom implementations

#### 4. Profile Cloning from Git
- Instantiate new profile directly from remote Git repository
- Unique for bootstrapping or trying others' configurations
- Lowers barrier to entry, encourages sharing

### 4.5 Trade-offs: Simplicity vs Features

#### What dotme Gains

**Ultimate Transparency**
- Entire logic in plain sight within handful of shell scripts
- No hidden databases, complex state transitions, or compiled code

**Infinite Extensibility**
- Plugin can be any executable script
- Limitless power for any setup task without tool-specific constraints

**Minimal Cognitive Overhead**
- Simple conventions: create profile directory, put scripts in `plugins/`
- No complex commands or configuration files to learn

**Zero-Cost Abstraction**
- Doesn't impose worldview beyond simple file structure

#### What dotme Sacrifices

**Robustness and Error Handling**
- Relies on user to write robust, idempotent, safe shell scripts
- Mistakes in plugins can have unintended consequences
- chezmoi has built-in safeguards

**Advanced Machine Management**
- Lacks sophisticated templating for subtle configuration differences across many machines

**Built-in Security**
- Secret management entirely out of scope
- Critical feature missing for modern workflows

**Discoverability of State**
- Must read all plugin scripts to understand what dotme manages
- No central declarative file summarizing desired state

---

## 5. Decision Matrix

### Choose dotme if:
- You are a "power scripter" highly proficient in shell
- You find other tools too magical or restrictive
- You have a folder of custom `setup.sh` scripts already
- You want to build your own perfect system, not adopt someone else's
- You value absolute transparency over convenience features
- You're already using mise for tool management

### Choose chezmoi if:
- You manage many machines with minor differences
- You need robust secret management
- You want stateful, idempotent operations with safeguards
- You prefer a mature, feature-complete solution
- Cross-platform consistency is critical

### Choose yadm if:
- You're Git-proficient and want minimal abstraction
- You need built-in encryption (GPG)
- You want a simple templating system
- You prefer Git workflow for all dotfile operations

### Choose nix/home-manager if:
- Reproducibility is paramount
- You're willing to invest in learning Nix
- You want declarative, functional configuration
- Bit-for-bit identical environments across machines required

### Choose dotbot if:
- You prefer declarative YAML over imperative scripts
- You want self-contained installation via Git submodule
- You're comfortable with Python ecosystem
- Onboarding team members with varied skill levels

### Choose Stow if:
- You want the simplest possible symlink manager
- You're comfortable with Perl
- You don't need tool installation or complex profiles
- Unix philosophy appeals to you

---

## 6. Conclusion

The dotfile/environment management landscape shows clear evolution:
- **Simple symlink managers** (Stow) → **Stateful template tools** (chezmoi)
- **Shell-based version managers** (asdf) → **Compiled alternatives** (mise) → **Declarative paradigms** (Nix)

**dotme occupies unique space:** It's a minimalist orchestrator bridging raw shell scripts and feature-rich tools. It prioritizes transparency and extensibility over built-in features, making it ideal for experienced developers who value understanding and customizing their entire toolchain.

**Target user:** The power user who has always maintained custom setup scripts and wants a lightweight, enjoyable framework to formalize that practice without sacrificing control or transparency.

**Not for:** Teams requiring secret management, managing large fleets with subtle variations, or users preferring declarative configuration over imperative scripting.

---

## 7. References

### Primary Research Sources
- Tool documentation and official websites
- GitHub repositories and community discussions
- **Multi-model consensus analysis using Zen MCP**
  - Models: Gemini-2.5-pro (neutral stance), GPT-5-pro (for stance)
  - Date: 2025-11-17
  - Methodology: Structured debate to identify true competitors vs partial solutions
- dotme implementation specification (/Users/fabio/.me/archive/EXPANDED-FEATURES.md)

### Consensus Analysis Methodology

This benchmark was updated using multi-model consensus analysis to rigorously evaluate which tools truly compete with dotme's complete value proposition:

**Models Consulted:**
1. **Gemini-2.5-pro** (neutral stance) - Evaluated all tools against strict criteria
2. **GPT-5-pro** (for stance) - Argued existing tools DO solve dotme's problem

**Evaluation Criteria:**
Tools must provide ALL of these capabilities to be considered complete competitors:
- Git-based versioning of multi-tool preferences in one repository
- Tool installation management (not just configuration)
- Native profile switching (not manual config swapping)
- Easy sharing of complete setups via git clone

**Key Findings:**
- Only 4 tools match complete criteria: chezmoi, yadm, nix/home-manager, dotdrop
- Many tools (Stow, rcm, mise, asdf) solve partial problems and are complementary, not competitors
- dotme's uniqueness is in minimalist orchestrator approach, not feature set
- Industry trend: movement from simple symlink managers toward comprehensive lifecycle management

**Consensus Confidence:** High (both models agreed on categorization)

### Tool Links
- **GNU Stow:** https://www.gnu.org/software/stow/
- **chezmoi:** https://www.chezmoi.io/
- **yadm:** https://yadm.io/
- **rcm:** https://github.com/thoughtbot/rcm
- **dotbot:** https://github.com/anishathalye/dotbot
- **mise:** https://mise.jdx.dev/
- **asdf:** https://asdf-vm.com/
- **devbox:** https://www.jetpack.io/devbox/
- **nix:** https://nixos.org/
- **home-manager:** https://github.com/nix-community/home-manager
- **direnv:** https://direnv.net/
- **mackup:** https://github.com/lra/mackup
- **dotdrop:** https://github.com/deadc0de6/dotdrop

---

*Benchmark created: 2025-11-17*
*Multi-model consensus analysis conducted with Zen MCP: Gemini-2.5-pro + GPT-5-pro*
*Updated: 2025-11-17 with corrected competitive landscape analysis*
