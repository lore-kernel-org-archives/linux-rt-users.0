Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47263D8105
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634232; cv=none; b=qtEkCAa1yUAgFbjoMZmsN3PC6LKbxTXsncK3/njagE+VKQ5Hk+lb//fE81mVYoxkKjJBMhKAxx76dxgSKNG0oj4FWdO1TC38UH6R6GNr+ZL17KGBdyypUqNHa96EubBuALq/+FDGIfqlIgxyPf+4VpVj4kpUDKYtbCe+ko8CkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634232; c=relaxed/simple;
	bh=Uuf4ZzJzH+f7f5anFkIpRBgD6UWiSG7vLHzWEfJRak0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOx0k7XdS8aRR0HE01p6mNcI0E8zZ9fN5d15PeneJwekpudFyGBXgzKJw33fOF7KpjD5ioDb5pTchNNfIw1G9JfmEscMEex2GekvLNJ54L6bwDnmWusj03WvN/T5LtVRgN+8Km2XAdaUdZ87bviafwniKY7T1PQSxxAXcYYo2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTH59Uxg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTH59Uxg"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51778069c31so43176481cf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634230; x=1782239030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHdBt2ekxN9TotLgyajpFp/qBlNyChj8Wwc95EfLuAs=;
        b=oTH59UxgJ46e+DnHEOpuYCuUlKZizslBSxZFt6KP9L429sni+u1WyxYG0Hb0fQjRup
         xNylxaGhEt6Vht5jd5wU9c8fMftdpP0oJa9qF2chh3A+iGaaOaTmQo68A91kbfsk8JnT
         XnyEXiapKki5OYVn/YeSaHETYiZ5Td26LiT7Atf+u0wHJaDKzbWnm/vwXby8x3EYHHTx
         0GblnosfskaIKNMR6CE5Nnxz4gJaHCzIaw1lMcqFS1ZUjLL7F/B0Zl0Ow3JIu1gxW/iE
         w8cF86LmKX5X0kHjqXDWEStpT5iY5XM9pK31v6T0BNdRdxgPIYMZP0v2SAEoVEjk9rA5
         ozWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634230; x=1782239030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHdBt2ekxN9TotLgyajpFp/qBlNyChj8Wwc95EfLuAs=;
        b=BevQhuxZJXT/mslfQJSoYnfUVW4tc9jN+4Mb+1nblhQO1MtkyUliTBE3Lqt+aR1RJe
         AovThJqFJ2p4CCYQ7jSnZ5xigu2alchK/EoEqFkpd1RnVmS9/3xoUTId7tW53dOFP6xt
         lluVA+YfmzWjwYskGd4Z1UlJWR99wZOwrdwhueEnnOXEbLeNdx4XJDicM0RoqI9tmq00
         uurocIqMOl8cc/rgkitJLlL6vlOM6t+ER39kgkK/TJsKf5ZkWDgx+pk3s4UM60BXMKAg
         DM8dZ0EKjBKF5svKTT3uuhLH/TfEBK0v903Hi5eTe2KgkTZsdJa0msiYCJcT/sFm5Avo
         C3sQ==
X-Gm-Message-State: AOJu0YyobVyH9ljBXF+JYGYGyPr5upSIwHdPS4kqLq9WF4g+K/WneXr+
	H6b5+V0bc9BpeNXjTrTUmAzgG1qmNvmgjuHb+olJ7vloCx8uVuUz+JotSDqdLw==
X-Gm-Gg: Acq92OGbD2AYUWhjDfS6gleN4pnfUGoFG6WUyPRboSL8cN9qfPLqLjfFUHoQ7yYZH5m
	zGTcU6idLqJTjuGLtM+G1mYmLE7b211Sr/k1WkGcdZp0RQVMDvum5sepQIiZw95o3JEsDckxM4H
	2uID0PEpyXbJN3Dfc4Y1yllsqKgFx+fmpcsKgF9tqAwREZhJULO2SDYS0Jaop/30m2pMR4xzxq8
	n2TOFP8D/9n3SQrInxV6QWozhPO2JW3qe+F4SsqUsnJMN0fMtUaXwlC72ZZCZHMcPFNmiYoNsS0
	pDzPRz9rmtyHi1juiHr3b11X/aMiL08FGF7VktokkMgZ9OxiWZbjpAiYDAmNxo1ddwrTynnWbwD
	vFO9+IH88gliihtOiFvq/EM4LU+zqP5JORhk+w+LlKOQ2GwT44LJ5jG8bnjjttAKobpXMHuo5iW
	w/iOE9rBwXRPjQeFGj6o+DRVWnC/koOtuDcIFBcJ/km5WSphmO1iBJF5KzlpqcBMNoRhW9nDMOn
	jFFaXymAgOqL2Joj11WCwzn8iNIOJZNA97adoTZJoTQim4PufTfLjQfyd7hrfWoEoAJPaSyULz2
	HaBX4Qww
X-Received: by 2002:ac8:6f13:0:b0:517:29b1:5433 with SMTP id d75a77b69052e-519ac24f38cmr426361cf.24.1781634229460;
        Tue, 16 Jun 2026 11:23:49 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb544533sm145389911cf.0.2026.06.16.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:23:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH 2/2] tuna: Add AGENTS.md guide for AI coding assistants
Date: Tue, 16 Jun 2026 14:23:32 -0400
Message-ID: <20260616182338.310541-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616182338.310541-1-jkacur@redhat.com>
References: <20260616182338.310541-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add comprehensive documentation for AI coding assistants working with
the tuna codebase. This guide covers project architecture, development
guidelines, build system, testing, and key components including the CLI,
GUI, scheduler management, and CPU power management.

The document is useful for both AI assistants and human developers as
a comprehensive reference to the project structure and conventions.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 AGENTS.md | 415 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 415 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 000000000000..2ae59d8825d2
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,415 @@
+SPDX-License-Identifier: GPL-2.0-only
+
+Copyright 2026 John Kacur <jkacur@redhat.com>
+
+# AGENTS.md - AI Coding Assistant Guide for tuna
+
+This document provides guidance for AI coding assistants working with the tuna codebase.
+
+## Project Overview
+
+**tuna** is a program for tuning running processes, threads, and interrupt handlers (IRQs) on Linux systems. It provides both a graphical interface and command-line tools for adjusting scheduler policies, priorities, and CPU affinity to optimize real-time performance.
+
+- **License**: GPL-2.0-only
+- **Language**: Python 3.10+
+- **Primary Maintainer**: John Kacur <jkacur@redhat.com>
+- **Original Author**: Arnaldo Carvalho de Melo <acme@redhat.com>
+- **Repository**: https://git.kernel.org/pub/scm/utils/tuna/tuna.git/
+
+## Architecture
+
+### Directory Structure
+
+```
+tuna/
+├── tuna-cmd.py                   # Main CLI entry point
+├── oscilloscope-cmd.py           # Latency visualization tool
+├── tuna/                         # Core Python package
+│   ├── __init__.py              # Package initialization
+│   ├── tuna.py                  # Core logic and thread/IRQ manipulation
+│   ├── tuna_gui.py              # GTK GUI main window
+│   ├── tuna_sched.py            # Scheduler policy/priority handling
+│   ├── cpupower.py              # CPU power state management
+│   ├── sysfs.py                 # Sysfs interface utilities
+│   ├── new_eth.py               # Network interface utilities
+│   ├── oscilloscope.py          # Oscilloscope visualization
+│   ├── config.py                # Configuration file handling
+│   ├── help.py                  # Help text and documentation
+│   ├── utils.py                 # Utility functions
+│   ├── tuna_gui.glade           # GTK GUI layout definition
+│   └── gui/                     # GUI components
+│       ├── __init__.py          # GUI package initialization
+│       ├── commonview.py        # Shared GUI view components
+│       ├── cpuview.py           # CPU view widget
+│       ├── irqview.py           # IRQ view widget
+│       ├── procview.py          # Process/thread view widget
+│       ├── profileview.py       # Profile management view
+│       └── util.py              # GUI utility functions
+├── docs/                        # Documentation
+│   ├── tuna.8                   # Man page
+│   ├── oscilloscope+tuna.html   # HTML documentation
+│   └── oscilloscope+tuna.pdf    # PDF documentation
+├── tests/                       # Test suite
+│   ├── run_tests.sh             # Test runner script
+│   ├── test_converters.py       # Unit tests for converter functions
+│   ├── test_eperm_handling.py   # Tests for EPERM error handling
+│   └── README.md                # Testing documentation
+├── etc/                         # Configuration files
+│   └── tuna/                    # Example tuna profiles
+├── help/                        # Help files
+│   └── kthreads/                # Kernel thread documentation
+├── po/                          # Translations (gettext)
+├── patches/                     # Patch queue (if any)
+├── local/                       # Local development notes
+├── setup.py                     # Legacy setuptools configuration
+├── pyproject.toml               # Modern Python project metadata
+├── Makefile                     # Build and test targets
+├── tuna.desktop                 # Desktop application launcher
+├── org.tuna.policy              # PolicyKit policy file
+└── ChangeLog                    # Change history
+```
+
+### Core Components
+
+1. **Main CLI** (`tuna-cmd.py`)
+   - Command-line argument parsing using argparse
+   - Subcommand architecture (isolate, move, run, etc.)
+   - Thread and IRQ manipulation
+   - Profile save/load functionality
+
+2. **Core Library** (`tuna/tuna.py`)
+   - Process and thread enumeration
+   - IRQ handling and manipulation
+   - CPU affinity management
+   - Scheduler policy and priority setting
+   - Integration with python-linux-procfs
+
+3. **GUI** (`tuna/tuna_gui.py`, `tuna/gui/`)
+   - GTK-based graphical interface
+   - Interactive views for CPUs, processes, threads, and IRQs
+   - Drag-and-drop CPU affinity assignment
+   - Real-time updates of system state
+   - Profile management
+
+4. **Scheduler Management** (`tuna/tuna_sched.py`)
+   - Parsing and setting scheduler policies (SCHED_FIFO, SCHED_RR, SCHED_OTHER, etc.)
+   - RT priority range validation
+   - Policy name to constant conversion
+
+5. **Oscilloscope** (`tuna/oscilloscope.py`, `oscilloscope-cmd.py`)
+   - Real-time latency visualization
+   - Multi-threaded latency monitoring
+   - Graphical display of scheduling behavior
+
+6. **CPU Power Management** (`tuna/cpupower.py`)
+   - CPU idle state (C-state) management
+   - Enable/disable idle states per CPU
+   - Query idle state information
+
+7. **Utilities**
+   - `tuna/sysfs.py` - Sysfs interface helpers
+   - `tuna/new_eth.py` - Network interface utilities
+   - `tuna/utils.py` - General utility functions
+   - `tuna/config.py` - Configuration file parsing
+
+## Development Guidelines
+
+### Code Style
+
+- Follow PEP 8 Python style guidelines
+- Use 4-space indentation (no tabs)
+- SPDX license identifier at top of each file: `# SPDX-License-Identifier: GPL-2.0-only`
+- Use descriptive variable names
+- Add docstrings for modules and functions
+
+### Python Version
+
+- Target Python 3.10+ for compatibility with RHEL 9+
+- Use modern Python features (type hints encouraged)
+- Avoid deprecated Python 2 constructs
+
+### Dependencies
+
+**Required**:
+- Python >= 3.10
+- python-linux-procfs - Process information library
+
+**Optional** (for GUI):
+- PyGObject (python3-gobject)
+- GTK 3
+- python3-inet_diag (for network socket information)
+
+**System utilities**:
+- PolicyKit (for privilege escalation)
+
+## Build and Installation
+
+### Build Commands
+
+```bash
+# Run unit tests
+make tests
+# or
+make unit-tests
+
+# Run EPERM handling tests
+make test-eperm
+
+# Clean Python cache files
+make pyclean
+
+# Generate ctags
+make tags
+
+# Clean generated logs
+make cleanlogs
+
+# Full clean
+make clean
+```
+
+### Installation
+
+```bash
+# Install with setup.py
+python3 setup.py install
+
+# Install with pip (development mode)
+pip install -e .
+
+# Install via system package manager (Fedora/RHEL)
+dnf install tuna
+```
+
+## Testing
+
+### Test Structure
+
+1. **Unit Tests** (`tests/test_converters.py`)
+   - Tests for CPU list parsing
+   - Tests for thread list parsing
+   - Tests for scheduler policy/priority parsing
+   - Run with: `./tests/run_tests.sh` or `make tests`
+
+2. **EPERM Tests** (`tests/test_eperm_handling.py`)
+   - Tests for handling permission errors gracefully
+   - Validates that tuna continues when operations fail with EPERM
+   - Run with: `make test-eperm`
+
+### Important Testing Notes
+
+- Most tuna operations require root privileges
+- Tests should handle permission errors gracefully
+- GUI tests are not automated (require manual testing)
+
+## Common Tasks
+
+### Adding a New Subcommand
+
+1. Edit `tuna-cmd.py`
+2. Add new parser in `gen_parser()` function
+3. Add command handler function
+4. Update man page (`docs/tuna.8`)
+5. Add tests if applicable
+
+### Modifying Thread/IRQ Manipulation
+
+- Core logic is in `tuna/tuna.py`
+- Uses procfs library for process information
+- IRQ affinity via `/proc/irq/*/smp_affinity` or `/proc/irq/*/smp_affinity_list`
+- Thread affinity via `sched_setaffinity()`
+
+### Modifying GUI
+
+- Main window: `tuna/tuna_gui.py`
+- GUI layout: `tuna/tuna_gui.glade` (edit with Glade)
+- View components: `tuna/gui/` directory
+- Use GTK 3 APIs (PyGObject)
+
+### Working with Scheduler Policies
+
+Tuna supports all Linux scheduler policies:
+
+**Supported Scheduler Policies:**
+- `SCHED_OTHER` (or `OTHER`) - Default time-sharing scheduler for normal tasks
+- `SCHED_FIFO` (or `FIFO`) - Realtime FIFO scheduler (priority 1-99)
+- `SCHED_RR` (or `RR`) - Realtime round-robin scheduler (priority 1-99)
+- `SCHED_BATCH` (or `BATCH`) - Batch processing, lower priority than SCHED_OTHER (priority 0)
+- `SCHED_IDLE` (or `IDLE`) - Very low priority, runs only when no other tasks are runnable (priority 0)
+- `SCHED_DEADLINE` (or `DEADLINE`) - Deadline scheduling for guaranteed bandwidth
+
+**Realtime Policies:** Only SCHED_FIFO and SCHED_RR are considered realtime policies.
+
+```python
+from tuna import tuna_sched
+
+# Parse policy:priority string (FIFO realtime with priority 50)
+policy, priority = tuna_sched.get_policy_and_rtprio("FIFO:50")
+
+# Batch policy (priority must be 0)
+policy, priority = tuna_sched.get_policy_and_rtprio("BATCH:0")
+
+# Idle policy (priority must be 0)
+policy, priority = tuna_sched.get_policy_and_rtprio("IDLE:0")
+
+# Set thread scheduler
+tuna_sched.set_thread_sched(pid, tid, policy, priority)
+```
+
+## Configuration
+
+### Profile Files
+
+Tuna supports profile files that describe system tuning configurations:
+
+```
+# Example profile format
+# Isolate CPUs 2-3
+isolate_cpus: 2-3
+
+# Move IRQ 16 to CPU 0
+irq_16_affinity: 0
+
+# Set thread priority
+thread_1234_policy: FIFO:80
+```
+
+Profiles can be saved with `tuna save` and applied with `tuna profilename`.
+
+## CLI Usage Examples
+
+```bash
+# Show current state
+tuna
+
+# Isolate CPUs 2-3 (move all threads/IRQs away)
+tuna isolate -c 2-3
+
+# Move thread 1234 to CPU 4
+tuna move -t 1234 -c 4
+
+# Set thread scheduler policy
+tuna threads -t 1234 -p FIFO:80
+
+# Move IRQ 16 to CPU 0
+tuna move -q 16 -c 0
+
+# Disable C-states on CPU 2
+tuna cpu_power -c 2 --disable 2
+
+# Run command on isolated CPUs
+tuna run -c 2-3 -- ./my-rt-app
+```
+
+## GUI Usage
+
+Launch tuna without arguments to start the GUI:
+
+```bash
+tuna
+```
+
+The GUI provides:
+- Interactive CPU, thread, and IRQ views
+- Drag-and-drop affinity assignment
+- Real-time system state updates
+- Profile save/load
+- Visual indication of isolated CPUs
+
+## Key Files
+
+- `tuna-cmd.py` - CLI entry point
+- `tuna/tuna.py` - Core thread/IRQ manipulation
+- `tuna/tuna_gui.py` - GUI main window
+- `tuna/tuna_sched.py` - Scheduler policy handling
+- `docs/tuna.8` - Man page
+- `tests/run_tests.sh` - Test runner
+
+## Debugging
+
+Enable debug output:
+
+```bash
+# CLI debug logging to file
+tuna -L DEBUG <command>
+
+# CLI debug logging to console
+tuna -D <command>
+```
+
+Debug logs include detailed information about:
+- Argument parsing
+- Thread and IRQ operations
+- Permission errors
+- System state changes
+
+## Common Gotchas
+
+1. **Root Required**: Most tuna operations require root/sudo privileges
+2. **PolicyKit**: GUI uses PolicyKit for privilege escalation
+3. **EPERM Handling**: Some operations may fail with EPERM (e.g., PID 1, containerized processes)
+   - Tuna should warn and continue, not crash
+4. **Kernel Threads**: Not all kernel threads can be moved to different CPUs
+5. **IRQ Affinity**: Some IRQs may not support affinity changes
+6. **CPU Hotplug**: Tuna assumes static CPU configuration during runtime
+7. **GUI Dependencies**: GUI requires PyGObject and GTK 3
+8. **Converter Functions**: Argument type converters should not have side effects (recent fix)
+
+## Recent Changes
+
+Check `git log` for recent commits. Notable recent development:
+
+**Code Quality Improvements:**
+- Eliminated global variables (`ps`, `irqs`) for better modularity
+- Removed side effects from argparse type converters
+- Deferred type conversions for cleaner argument parsing
+
+**Testing:**
+- Added unit tests for converter functions
+- Improved test documentation
+- Added `.local/` to gitignore for development notes
+
+**Copyright:**
+- Updated copyright notices to reflect current maintainership
+
+## Support and Contact
+
+- Maintainer: John Kacur <jkacur@redhat.com>
+- Mailing list: linux-rt-users@vger.kernel.org
+- Bug reports: Send to maintainer with mailing list CC'd
+
+## Git Workflow
+
+- **Main branch**: `main`
+- **Repository**: https://git.kernel.org/pub/scm/utils/tuna/tuna.git/
+- **Patch submission**: Use standard git format-patch/send-email, send to maintainer with mailing list CC'd
+- **Mailing list**: linux-rt-users@vger.kernel.org
+
+### Development Workflow
+
+1. Make changes to code
+2. Run unit tests: `make tests`
+3. Test manually with root privileges: `sudo tuna <command>`
+4. Update documentation if needed
+5. Submit patches to mailing list or create pull request
+
+## Additional Notes for AI Assistants
+
+1. **Python Version**: Target Python 3.10+ for RHEL 9+ compatibility
+2. **Privilege Handling**: Always check for root privileges and fail gracefully
+3. **Error Recovery**: Permission errors (EPERM) should warn, not crash
+4. **GUI vs CLI**: Changes to core logic affect both interfaces
+5. **procfs Dependency**: Uses python-linux-procfs for process information
+6. **Thread Safety**: GUI runs in GTK main loop, use appropriate threading
+7. **Translations**: Use gettext for user-facing strings
+8. **Policy Files**: Profile format is custom, not standardized
+
+## Related Projects
+
+- **rteval**: Real-time evaluation tool - https://git.kernel.org/pub/scm/utils/rteval/rteval.git
+- **rt-tests**: Real-time test suite - https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
+
+---
+
+**Last Updated**: 2026-06-16
+**Document Version**: 1.0
-- 
2.54.0

