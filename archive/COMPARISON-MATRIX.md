# dotme vs True Competitors: Feature Comparison Matrix

## Core Features Comparison

| Feature | dotme | chezmoi | yadm | nix/home-manager | dotdrop |
|---------|-------|---------|------|------------------|---------|
| **Track dotfiles for multiple tools in single repo** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **Easy to configure preferences across multiple machines** | ⚠️ Manual (duplicate files) | ✅ Templates | ✅ Alternate files | ✅ Nix expressions | ✅ Jinja2 templates |
| **Easy to switch profiles (experiment with others' setups)** | ✅✅ Excellent (`./itsame mario github.com/mario/dotme`) | ⚠️ Manual (template variables) | ⚠️ Manual (alternate branches) | ⚠️ Complex (flake switching) | ⚠️ Manual (YAML profiles) |
| **Clone & activate in one command** | ✅ Yes (`./itsame mario <url>`) | ❌ No (multi-step) | ❌ No (multi-step) | ❌ No (multi-step) | ❌ No (multi-step) |
| **Tool installation management** | ✅ Yes (plugins check + install) | ✅ Yes (`run_` scripts) | ✅ Yes (bootstrap) | ✅ Yes (declarative packages) | ✅ Yes (shell commands) |
| **Profile isolation (separate directories)** | ✅ Yes (`.me`, `.me.mario`) | ❌ No (single state) | ❌ No (single repo) | ⚠️ Partial (generations) | ❌ No (single state) |
| **Git-based sharing** | ✅ Native | ✅ Native | ✅ Native | ✅ Native (flakes) | ✅ Native |
| **Secret management** | ❌ External only | ✅ Built-in (age, 1Password) | ✅ Built-in (GPG) | ✅ Built-in (sops-nix) | ❌ External only |
| **Templating for variations** | ❌ No (duplicate files) | ✅ Advanced (Go templates) | ⚠️ Basic (alternate files) | ✅ Advanced (Nix language) | ✅ Advanced (Jinja2) |
| **Idempotency guarantees** | ⚠️ Plugin-dependent | ✅ Strong (stateful) | ⚠️ Script-dependent | ✅ Strong (declarative) | ⚠️ Script-dependent |
| **Cross-platform support** | ✅ bash (macOS/Linux) | ✅ Excellent (Go binary) | ✅ bash (macOS/Linux) | ⚠️ Limited Windows | ✅ Python (cross-platform) |

## Implementation Characteristics

| Characteristic | dotme | chezmoi | yadm | nix/home-manager | dotdrop |
|----------------|-------|---------|------|------------------|---------|
| **Core implementation** | ~50 LOC bash | ~40k LOC Go | ~3k LOC bash | ~50k LOC Nix | ~10k LOC Python |
| **Runtime dependency** | bash | None (static binary) | bash, git | Nix | Python, PyYAML |
| **Learning curve** | Minimal (bash scripts) | Moderate (many commands) | Low (git familiarity) | Steep (Nix language) | Moderate (YAML + Jinja2) |
| **Transparency** | ✅✅ Maximum (plain scripts) | ⚠️ Compiled binary + state DB | ✅ High (wrapper around git) | ⚠️ Declarative abstraction | ⚠️ YAML + Python |
| **Extensibility** | ✅✅ Infinite (any script) | ✅ Good (`run_` scripts) | ✅ Good (bootstrap) | ✅✅ Excellent (Nix packages) | ✅ Good (hooks/actions) |
| **Maintenance burden** | Low (minimal core) | Low (active project) | Low (stable) | High (Nix complexity) | Moderate (Python deps) |
| **GitHub stars** | New | ~11.5k | ~4.6k | ~10.4k (nix), ~5.7k (home-mgr) | ~1.7k |
| **Development status** | New | Very active | Active | Very active | Active |

## Profile Switching Deep Dive

| Aspect | dotme | chezmoi | yadm | nix/home-manager | dotdrop |
|--------|-------|---------|------|------------------|---------|
| **Switching mechanism** | Directory-based | Template variables | Git branches/alternate | Nix profiles/generations | YAML profile selection |
| **Switch command** | `./itsame mario` | Edit `.chezmoi.toml`, `chezmoi apply` | `yadm alt`, manual branch switch | `home-manager switch --flake` | `dotdrop install -p profile` |
| **Clone others' setup** | `./itsame mario <url>` (1 cmd) | `chezmoi init <url>`, edit vars, apply (3+ steps) | `yadm clone <url>`, bootstrap (2+ steps) | `nix run <flake>` (complex) | Clone, edit config, install (3+ steps) |
| **Profile isolation** | ✅ Separate dirs (`.me.mario`) | ❌ Shared state DB | ❌ Single repo state | ⚠️ Generations (not profiles) | ❌ Single state |
| **Experiment safety** | ✅ High (isolated, easy rollback) | ⚠️ Medium (apply/diff) | ⚠️ Medium (git-based) | ✅ High (generations) | ⚠️ Medium (apply/diff) |
| **Return to main profile** | `./itsame main` | Edit vars, apply | Switch branch | Switch generation | `dotdrop install -p main` |

## Use Case Fit Matrix

| Use Case | dotme | chezmoi | yadm | nix/home-manager | dotdrop |
|----------|-------|---------|------|------------------|---------|
| **Power user wanting transparency** | ✅✅ Ideal | ⚠️ Compiled code | ✅ Good | ⚠️ Abstraction | ⚠️ Abstraction |
| **Trying others' complete setups** | ✅✅ Excellent | ⚠️ Manual | ⚠️ Manual | ⚠️ Complex | ⚠️ Manual |
| **Managing 10+ machines with variations** | ❌ File duplication | ✅✅ Templates | ✅ Good | ✅✅ Nix magic | ✅✅ Templates |
| **Secret management required** | ❌ External | ✅✅ Built-in | ✅✅ Built-in | ✅✅ Built-in | ❌ External |
| **Team onboarding** | ✅ Good (simple) | ✅✅ Excellent | ✅ Good | ❌ Steep | ✅ Good |
| **Bit-for-bit reproducibility** | ❌ No | ⚠️ Best-effort | ❌ No | ✅✅ Guaranteed | ❌ No |
| **Quick experimentation** | ✅✅ Instant | ⚠️ Multi-step | ⚠️ Multi-step | ❌ Complex | ⚠️ Multi-step |
| **Custom tool installations** | ✅✅ Infinite flexibility | ✅ Good | ✅ Good | ✅✅ Nix packages | ✅ Good |

## Decision Matrix

### Choose **dotme** if:
- ✅ You want to **quickly experiment** with others' complete setups
- ✅ You value **maximum transparency** (understand every line)
- ✅ You're comfortable writing bash scripts
- ✅ You have **few machines** or **distinct profiles** (work/personal)
- ✅ You want **profile isolation** (separate directories)
- ✅ Secret management via external tools is acceptable

### Choose **chezmoi** if:
- ✅ You manage **many machines** with subtle variations
- ✅ You need **built-in secret management**
- ✅ You want **stateful, idempotent** operations with safety guarantees
- ✅ You prefer a mature, feature-complete solution
- ✅ Cross-platform consistency is critical
- ❌ Profile switching is secondary (manual template variables)

### Choose **yadm** if:
- ✅ You're **Git-proficient** and want minimal abstraction
- ✅ You need **built-in encryption** (GPG)
- ✅ You want a simple alternate file system
- ✅ You prefer Git workflow for all operations
- ❌ Profile switching is secondary (branch management)

### Choose **nix/home-manager** if:
- ✅ **Reproducibility is paramount**
- ✅ You're willing to invest in learning Nix
- ✅ You want declarative, functional configuration
- ✅ Bit-for-bit identical environments required
- ❌ High learning curve acceptable

### Choose **dotdrop** if:
- ✅ You prefer **declarative YAML** over imperative scripts
- ✅ You want **powerful Jinja2 templating**
- ✅ You're comfortable with Python ecosystem
- ✅ You have multiple profiles but switch infrequently
- ❌ Profile switching is manual YAML editing

## Key Differentiators Summary

### 🏆 **dotme's Unique Strengths:**
1. **Best profile switching UX** - `./itsame mario <url>` clones & activates in one command
2. **Profile isolation** - Separate directories for each profile (`.me`, `.me.mario`)
3. **Maximum transparency** - Plain bash scripts, no compiled code or state DB
4. **Persona concept** - "Adopting Mario's setup" more intuitive than "switching profiles"

### 🏆 **chezmoi's Unique Strengths:**
1. **Stateful management** - Knows state of every file, strong idempotency
2. **Built-in secrets** - age encryption, 1Password integration
3. **Template power** - Handle 100+ machines with subtle variations
4. **Mature ecosystem** - Large community, extensive docs

### 🏆 **yadm's Unique Strengths:**
1. **Git-native** - Wrapper around bare git repo, minimal abstraction
2. **Simplicity** - Feels like using git directly
3. **Built-in GPG** - Native encryption support

### 🏆 **nix/home-manager's Unique Strengths:**
1. **Reproducibility** - Bit-for-bit identical environments
2. **Declarative** - Entire system state in code
3. **Package management** - 80k+ packages in nixpkgs

### 🏆 **dotdrop's Unique Strengths:**
1. **Jinja2 templating** - Familiar to Python developers
2. **Declarative YAML** - Clear specification format
3. **Good balance** - Between simplicity and features

## Profile Switching Winner

### 🥇 **dotme wins for profile switching:**

**Why:**
- **One command** to clone & activate: `./itsame mario github.com/mario/dotme`
- **Profile isolation** in separate directories
- **Easy rollback**: `./itsame main`
- **Intuitive concept**: "becoming Mario" vs "switching profile variables"

**Comparison:**
- **chezmoi**: Requires editing `.chezmoi.toml` variables + reapply (multi-step, shared state)
- **yadm**: Requires branch switching + alternate file management (manual)
- **nix**: Requires flake understanding + complex switching (steep learning curve)
- **dotdrop**: Requires editing YAML profile selection + reinstall (manual)

**Use case:** Trying colleagues' complete setups for experimentation or learning.
