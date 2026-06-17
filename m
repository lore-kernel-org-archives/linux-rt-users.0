Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C348388899
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727680; cv=none; b=m12baJWdUfLj8yjs8+ZwmRu1s9Ua1YKiidV6/SDfx/KrfiDLN6U4VKuuZ7gZCGUnaeX0Gyne487wvJevnZnzo9tZSg4iRctwAx6yYBfvCdQ8uOhsUrOao62KqGxeFpB60S7kejmJVJ7gZfeP0gZxKJOEkPUXDW8XjDJJzISW3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727680; c=relaxed/simple;
	bh=0VT1zjKNWCSV4cVPHQBIQZJeV/Rf9xAWknKTgM3cTtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLwiVN96Qw6dI7z0v+OvJpSyhiRCFZ/ZhmWbaF+mPO3quTAGm0jIb537ECXxAANLl3Mke99hx4u5Wcu108o1m9rI6wsiapEsEqf0yRPglA8Yp3TMq1JsW70crl6c9QwOaZt3EVA9lk+HMGI7pC9Ly3ugljaa+em65JHlbpSWlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioy3uphs; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioy3uphs"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce9df4732cso1751796d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781727677; x=1782332477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBX/l+8SOomTz7IBuoHczG1Psl2zfCb6lYqlfFJah0E=;
        b=ioy3uphseKDGWdpnW4oPpAwFDxh4LuiIXUEfUIHHcQkF5lWimwAcW2ibCyiZk/nGsC
         liXyR+IA4/s3qziqDEvVc26RccrAYw6vgGMtnwhGsUnEv+aXCAMs13BZqcsBwsVz0g4t
         FkwqxOGRk1iHKU1gfSkNpGxCzFKNuqvfRb6DxHbhlxJsGSrKowVW0HAShlJrlh9lvb2q
         SRw65KzkZXDe4zU/gazfjfaJNdirE/Q5sADxXV2SCDp8mGPfc/78MYH63mWxb7d5F7dD
         mWBGpBvghdkVloWfqMytxswe2n77IXgBAGN+exWwDpT+UUrBnF+5eRcNaxYE45/oxNiq
         N3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781727677; x=1782332477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBX/l+8SOomTz7IBuoHczG1Psl2zfCb6lYqlfFJah0E=;
        b=DmkAcK87hxDCjutrw9jdEbPR+dBp7q7DJ/GJ4xzIdhLo+A9Qe8ecmd/e/e+MdWwX9s
         XMMBiwHo9SeEHWfd5TIFuxYF6o6CBlTTXBNeXampX8f7Vt79LjlkJmclUMvRj1QedLee
         NDlB6nzCI1bxQSGqQwUeZENNquXW9aavCyrH1EwefKo+5/aJ+qpzBMtsZNq8AXdpxaJN
         YCaiunnmUDGW8ALJcNN/bOlbs+lu+gFkr/LDoV3LTBN5z4Kp+bYHuMk3Ll0xmZ18kBjF
         QNQRuFct+9P7+NVxsYNnCnNf+Ten1pWXdnDfzb62oibFss+MjjFZ1UcssIoKduT/S6r1
         SbTw==
X-Gm-Message-State: AOJu0Yz400lqyvHH2YsdobLxgweoAMlg4OOKQt/2BxOP0/s5w0Bwf16n
	mRu86nOcD2KRcy9JwsmsfYYMP+olSaNoaq+UsX8Zs7DZRhQRb8TTAYKin/R2HQ==
X-Gm-Gg: AfdE7cmycq8hC6xyDEbRWNKIFJxpUzsx6p1UIWKZJ/dnK6/ngSwD5nifpIyQIAF1p4u
	8QwzzxIembiAvGqh2ANetKwhuch849ss0laYUsuHz7V3gbs5JagUUySrgXQj7zuO7jaTYII0/jM
	JL3GA6OxU8RK+cMTOAEBmy9qv8RjK4O0oq9+RVsVxDfY2VHygDXhlgRzUbJEj+BWeHqpzoU996Q
	YJgUjaUIdjlCwi2co4m0HcWzhMwBL1iYFaSy8Og+e5dM2bkwRLWuyiG3QGAjGPb1Sa82cot6q6V
	2z7NOytrCABSbak9Jpj2paWK2qlkPJ6s35rERQaHkoZzxZLCyHknntuVelzXoP1CH2eg8ilxI36
	01w8MTOvJi2ymDYj+qyeDNqnTmvyxBj3lvHzKVSybCR9e0pE6Gv+K36RP0mdifLveJ9kembLhlv
	/H9EZQcyNq9Q3OfQroKrYW5YR2KUZH4KowkoPicNnj/E4huIfeuQL0yBRgqFzMJkg5tu5vXzA1s
	g5cegUq0aefcoblvf0=
X-Received: by 2002:a05:6214:29e3:b0:8db:7881:afb8 with SMTP id 6a1803df08f44-8db80f4693dmr72725856d6.9.1781727676481;
        Wed, 17 Jun 2026 13:21:16 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f1dc7432sm71969046d6.19.2026.06.17.13.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 13:21:16 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 3/3] rt-tests: Add AGENTS.md guide for AI coding assistants
Date: Wed, 17 Jun 2026 16:20:56 -0400
Message-ID: <20260617202059.217693-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617202059.217693-1-jkacur@redhat.com>
References: <20260617202059.217693-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This guide is also useful for human developers new to the project.

Add comprehensive documentation for AI coding assistants working on the
rt-tests codebase. This guide covers:

- Project overview and architecture
- Core programs (cyclictest, hwlatdetect, pi_stress, etc.)
- Shared library components and build system
- Development guidelines including code style and checkpatch usage
- Testing procedures and debugging tools
- Common gotchas for real-time testing
- Related projects in the RT ecosystem (rteval, tuna, rtla, rv)
- Kernel documentation references

The guide is designed to help AI assistants quickly understand the
codebase structure, key patterns, and best practices when making
changes to rt-tests.

Python requirement set to 3.8+ based on language features used in the
codebase.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 AGENTS.md | 416 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 416 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 000000000000..d589fbfde0f5
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,416 @@
+SPDX-License-Identifier: GPL-2.0-only
+
+Copyright 2026 John Kacur <jkacur@redhat.com>
+
+# AGENTS.md - AI Coding Assistant Guide for rt-tests
+
+This document provides guidance for AI coding assistants working with the rt-tests codebase.
+
+## Project Overview
+
+**rt-tests** is a collection of programs for testing real-time Linux kernel behavior. These tools measure scheduling latency, test priority inheritance, validate deadline scheduling, and stress-test various real-time features of the Linux kernel.
+
+- **License**: GPL-2.0-only (some files GPL-2.0-or-later)
+- **Language**: C (with some Python utilities)
+- **Maintainers**: John Kacur <jkacur@redhat.com>, Clark Williams <williams@redhat.com>
+- **Repository**: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
+- **Mailing List**: linux-rt-users@vger.kernel.org
+
+## Architecture
+
+### Directory Structure
+
+```
+rt-tests/
+├── src/                          # Source code organized by program
+│   ├── cyclictest/              # Cyclictest program (main latency tester)
+│   ├── hackbench/               # Scheduler benchmark/stress test
+│   ├── hwlatdetect/             # Hardware latency detector (Python)
+│   ├── pi_tests/                # Priority inheritance tests
+│   ├── pmqtest/                 # POSIX message queue test
+│   ├── ptsematest/              # POSIX semaphore test
+│   ├── queuelat/                # Network queue latency detector
+│   ├── rt-migrate-test/         # RT migration test
+│   ├── sched_deadline/          # SCHED_DEADLINE tests
+│   ├── signaltest/              # Signal latency test
+│   ├── sigwaittest/             # Signal wait test
+│   ├── ssdd/                    # Stress, Strain, Duty, Duration test
+│   ├── svsematest/              # SysV semaphore test
+│   ├── oslat/                   # OS latency detector
+│   ├── backfire/                # Backfire test utility
+│   ├── lib/                     # Shared library code
+│   │   ├── rt-utils.c           # Common utilities (affinity, prio, tracing)
+│   │   ├── rt-numa.c            # NUMA support functions
+│   │   ├── rt-error.c           # Error handling
+│   │   ├── rt-sched.c           # Scheduler utilities
+│   │   ├── rt-get_cpu.c         # CPU detection
+│   │   └── histogram.c          # Histogram generation
+│   ├── include/                 # Common header files
+│   │   ├── rt-utils.h           # Utility function declarations
+│   │   ├── rt-numa.h            # NUMA declarations
+│   │   ├── rt-error.h           # Error handling declarations
+│   │   ├── rt-sched.h           # Scheduler declarations
+│   │   ├── rt-get_cpu.h         # CPU detection declarations
+│   │   ├── histogram.h          # Histogram declarations
+│   │   ├── pi_stress.h          # PI stress test definitions
+│   │   ├── pip_stress.h         # PIP stress test definitions
+│   │   └── bionic.h             # Android Bionic support
+│   └── arch/                    # Architecture-specific code
+│       └── android/             # Android-specific support
+├── Makefile                     # Build system
+├── README.markdown              # Usage documentation
+├── MAINTAINERS                  # Maintainer contact information
+├── COPYING                      # License text
+├── Dockerfile                   # Container build configuration
+├── get_pylib.py                 # Python library path helper
+├── feature/                     # Feature detection for build
+└── bld/                         # Build output directory
+```
+
+### Core Programs
+
+**cyclictest** - High-resolution timer latency tester (primary tool):
+- Measures scheduling latency and timer jitter
+- Multi-threaded with per-CPU thread support
+- Integrates with kernel tracing (ftrace)
+- Supports histogram output
+- Can trigger trace on latency threshold (`--breaktrace`)
+- Options for affinity, priority, interval, duration
+- Man page: src/cyclictest/cyclictest.8
+
+**hackbench** - Scheduler stress test and benchmark:
+- Creates groups of processes/threads exchanging messages
+- Stresses scheduler and IPC mechanisms
+- Useful for finding worst-case latencies under load
+
+**pi_stress / pip_stress** - Priority inheritance tests:
+- Tests kernel priority inheritance mechanisms
+- Validates priority ceiling protocol
+- Helps debug priority inversion issues
+
+**pmqtest / ptsematest / svsematest** - IPC latency tests:
+- Test POSIX message queues, POSIX semaphores, SysV semaphores
+- Measure wakeup latency through various IPC mechanisms
+
+**hwlatdetect** - Hardware/firmware latency detector (Python):
+- Detects System Management Interrupts (SMIs) and firmware delays
+- Uses kernel hwlat detector module
+- Runs in debugfs environment
+
+**queuelat** - Network queue latency detector:
+- Measures latency caused by network queue processing
+- Tests impact of network load on real-time performance
+
+**deadline_test / cyclicdeadline** - SCHED_DEADLINE tests:
+- Test and validate SCHED_DEADLINE scheduler
+- Deadline-based real-time scheduling
+
+**oslat** - OS latency detector:
+- Detects OS-induced latencies
+- Measures worst-case OS interference
+
+**signaltest / sigwaittest** - Signal latency tests:
+- Test signal delivery latency
+- Measure real-time signal performance
+
+**ssdd** - Stress, Strain, Duty, Duration:
+- Configurable stress test with various patterns
+- Tests system under different workloads
+
+**rt-migrate-test** - RT task migration test:
+- Tests real-time task migration behavior
+- Validates scheduler migration logic
+
+### Shared Library Components
+
+**rt-utils.c / rt-utils.h** - Common utilities:
+- `parse_cpumask()` - Parse CPU affinity masks
+- `numa_initialize()` - Initialize NUMA support
+- `enable_trace_mark()` - Enable kernel trace markers
+- `tracemark()` - Write trace markers
+- `get_tracers()` - Get available kernel tracers
+- `setkfifo()` - Set SCHED_FIFO priority
+- Priority, affinity, and tracing helpers
+
+**rt-numa.c / rt-numa.h** - NUMA support:
+- CPU topology detection
+- NUMA node management
+- Per-node thread allocation
+
+**rt-error.c / rt-error.h** - Error handling:
+- `fatal()` - Fatal error with exit
+- `err_exit()` - Error with errno
+- `warn()` - Warning messages
+- `info()` - Informational messages
+
+**histogram.c / histogram.h** - Latency histogram generation:
+- Collect latency samples into bins
+- Format histogram output
+- Calculate statistics (min, max, avg)
+
+**rt-sched.c / rt-sched.h** - Scheduler utilities:
+- Scheduler policy helpers
+- Priority validation
+
+**rt-get_cpu.c / rt-get_cpu.h** - CPU detection:
+- Get current CPU number
+- CPU affinity helpers
+
+### Python Utilities
+
+**hwlatdetect.py** - Hardware latency detector:
+- Detects SMIs and firmware-induced delays
+- Mounts/unmounts debugfs as needed
+- Uses kernel's hwlat_detector module
+- Supports duration, threshold, and window parameters
+
+**get_cyclictest_snapshot.py** - Cyclictest snapshot utility:
+- Captures cyclictest state while running
+- Reads /dev/shm/cyclictest-* files
+- Provides statistics and thread status
+
+**get_pylib.py** - Python library path helper:
+- Determines correct Python library installation path
+- Used by Makefile for Python tool installation
+
+## Development Guidelines
+
+### Code Style
+
+- Follow Linux kernel coding style (K&R style)
+- Use tabs for indentation (width 8)
+- Maximum line length: 80 characters
+- SPDX license identifier at top of each file: `// SPDX-License-Identifier: GPL-2.0-only`
+- Function names: lowercase with underscores (e.g., `parse_cpumask`)
+- Variable names: lowercase with underscores
+- Constants: UPPERCASE with underscores
+- **Checking code style**: Use the kernel's checkpatch.pl script to verify code style compliance:
+  ```bash
+  /path/to/kernel/scripts/checkpatch.pl --no-tree -f <file.c>
+  ```
+
+### C Standards and Dependencies
+
+- **C Standard**: C99 or later
+- **POSIX**: POSIX.1-2001 with real-time extensions
+- **Required Libraries**:
+  - pthread (POSIX threads)
+  - rt (POSIX real-time extensions)
+  - numa (NUMA support, optional)
+  - dl (dynamic loading)
+- **Optional Libraries**:
+  - cpupower (for deepest idle state support)
+
+### Python Code
+
+- **Python Version**: Python 3.8+
+- **Style**: PEP 8 Python style guide
+- **Shebang**: `#!/usr/bin/python3`
+- Use standard library modules when possible
+- Include docstrings for modules, classes, and functions
+
+### Error Handling
+
+- Use `err_exit()` for fatal errors with errno
+- Use `fatal()` for fatal errors without errno
+- Use `warn()` for warnings that don't stop execution
+- Check return values from all system calls
+- Handle interrupted system calls (EINTR)
+- Clean up resources (threads, memory, file descriptors) on error
+
+### Real-Time Programming Considerations
+
+1. **Memory Locking**: Lock memory with `mlockall(MCL_CURRENT | MCL_FUTURE)` to prevent page faults
+2. **Priority**: Use SCHED_FIFO or SCHED_DEADLINE for real-time threads
+3. **Affinity**: Pin threads to specific CPUs to avoid migration overhead
+4. **Stack Prefault**: Touch stack pages before real-time operation
+5. **Avoid Blocking**: Minimize system calls and library calls in RT critical sections
+6. **Signal Handling**: Use real-time signals when possible
+7. **Trace Integration**: Support ftrace integration for latency debugging
+
+## Build and Installation
+
+### Build Commands
+
+```bash
+# Install build dependencies (Debian/Ubuntu)
+sudo apt-get install build-essential libnuma-dev
+
+# Install build dependencies (Fedora/RHEL)
+sudo dnf install gcc make numactl-devel kernel-tools-libs-devel
+
+# Build all programs
+make
+
+# Build with debugging
+make DEBUG=1
+
+# Build specific program
+make cyclictest
+
+# Clean build artifacts
+make clean
+
+# Generate tags
+make tags
+```
+
+### Installation
+
+```bash
+# Install to /usr/local (default)
+sudo make install
+
+# Install to custom prefix
+sudo make prefix=/usr install
+
+# Install with compressed man pages
+sudo make MAN_COMPRESSION=gzip install
+```
+
+### Cross-Compilation
+
+```bash
+# Set cross-compiler
+make CROSS_COMPILE=aarch64-linux-gnu-
+
+# Build for Android
+make ostype=android
+```
+
+## Testing
+
+### Running cyclictest
+
+```bash
+# Basic test: one thread per CPU, SCHED_FIFO priority 99
+sudo ./cyclictest -a -t -p99
+
+# With histogram output
+sudo ./cyclictest -a -t -p99 -h 400 -q
+
+# With trace on latency spike
+sudo ./cyclictest -a -t -p99 --tracemark --breaktrace=100
+
+# Long duration test (24 hours)
+sudo ./cyclictest -a -t -p99 -D 24h -h 400 -q
+```
+
+### Running hwlatdetect
+
+```bash
+# Detect hardware latency for 60 seconds
+sudo ./hwlatdetect --duration=60
+
+# With threshold
+sudo ./hwlatdetect --duration=60 --threshold=10
+```
+
+### Testing Priority Inheritance
+
+```bash
+# Run pi_stress test
+sudo ./pi_stress
+
+# Run with specific parameters
+sudo ./pi_stress --inversions=100 --duration=60
+```
+
+## Key Files
+
+- `src/cyclictest/cyclictest.c` - Main latency testing tool
+- `src/lib/rt-utils.c` - Common utility functions
+- `src/lib/rt-numa.c` - NUMA support
+- `src/include/rt-utils.h` - Utility declarations
+- `src/hwlatdetect/hwlatdetect.py` - Hardware latency detector
+- `Makefile` - Build configuration
+- `README.markdown` - Usage documentation
+
+## Common Gotchas
+
+1. **Root Privileges**: Most tests require root to set real-time priorities and lock memory
+2. **Kernel Configuration**: RT tests require kernel with CONFIG_PREEMPT_RT or CONFIG_PREEMPT for best results
+3. **CPU Isolation**: For accurate results, isolate CPUs from scheduler (isolcpus kernel parameter)
+4. **Power Management**: Disable CPU frequency scaling and idle states for consistent results
+5. **NUMA Systems**: Be aware of memory locality on NUMA systems
+6. **Tracing Overhead**: Kernel tracing adds overhead; use only when needed
+7. **Signal Handling**: Proper cleanup on SIGINT/SIGTERM is important
+8. **Memory Locking**: Must lock memory before enabling real-time priority
+
+## Build System Notes
+
+The Makefile uses feature detection to conditionally enable features:
+
+- **libcpupower**: Detected via feature/test-feature.mak, enables `--deepest-idle-state` option
+- **NUMA**: Detected at build time, links with libnuma if available
+- **Python**: Detected via get_pylib.py, determines if Python utilities can be installed
+- **Architecture**: Detected via `$(CC) -dumpmachine` for platform-specific code
+
+### Makefile Variables
+
+- `VERSION`: Current version number
+- `DESTDIR`: Installation destination (for packaging)
+- `prefix`: Installation prefix (default: /usr/local)
+- `DEBUG`: Enable debug build (DEBUG=1)
+- `CROSS_COMPILE`: Cross-compiler prefix
+- `no_libcpupower`: Disable libcpupower (no_libcpupower=1)
+
+## Support and Contact
+
+- **Maintainers**:
+  - John Kacur <jkacur@redhat.com>
+  - Clark Williams <williams@redhat.com>
+- **Mailing List**: linux-rt-users@vger.kernel.org
+- **Bug Reports**: Send to maintainers with mailing list CC'd
+- **Patch Submissions**: Send to maintainers with mailing list CC'd
+
+## Git Workflow
+
+- **Main Branch**: `master`
+- **Repository**: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
+- **Patch Submission**: Use standard git format-patch/send-email workflow
+- **Commit Format**: Follow kernel commit message format
+
+### Development Workflow
+
+1. Make changes to code
+2. Build and test: `make && sudo ./cyclictest -a -t -p99`
+3. Run relevant tests to verify changes
+4. Update man pages if changing command-line options
+5. Commit with descriptive message
+6. Submit patches to maintainers with mailing list CC'd
+
+## Additional Notes for AI Assistants
+
+1. **Real-Time Focus**: All programs are designed for real-time system testing and analysis
+2. **Kernel Integration**: Heavy integration with Linux kernel features (ftrace, debugfs, scheduler)
+3. **Thread Safety**: Most programs are multi-threaded; be aware of synchronization
+4. **Signal Handling**: Programs must handle SIGINT/SIGTERM for graceful shutdown
+5. **Resource Cleanup**: Always clean up threads, memory, and file descriptors
+6. **Man Page Updates**: Update man pages when changing options or behavior
+7. **Backwards Compatibility**: Maintain compatibility with existing scripts and tools
+8. **Performance Critical**: Some code paths are performance-critical; avoid adding overhead
+9. **Architecture Support**: Code should work on x86_64, aarch64, ppc64le, s390x, RISC-V
+10. **Android Support**: Some programs support Android via Bionic compatibility layer
+
+## Related Projects
+
+Projects in the RT ecosystem:
+
+- **rteval**: Real-time evaluation suite - https://git.kernel.org/pub/scm/utils/rteval/rteval.git
+- **tuna**: Thread and IRQ tuning tool - https://git.kernel.org/pub/scm/utils/tuna/tuna.git
+- **rtla**: Real-time Linux analysis tool - https://www.kernel.org/doc/html/latest/tools/rtla/
+- **rv**: Runtime verification tool - https://www.kernel.org/doc/html/latest/tools/rv/
+- **Linux RT Kernel**: PREEMPT_RT patches - https://kernel.org/pub/linux/kernel/projects/rt/
+
+## References
+
+- **Linux Real-Time Wiki**: https://wiki.linuxfoundation.org/realtime/start
+- **OSADL Latency Plots**: https://www.osadl.org/QA-Farm-Realtime.qa-farm-about.0.html
+- **RT Kernel Documentation**: https://www.kernel.org/doc/Documentation/scheduler/sched-rt-group.txt
+- **High-resolution timers**: https://www.kernel.org/doc/html/latest/timers/hrtimers.html
+
+---
+
+**Last Updated**: 2026-06-17
+**Document Version**: 1.0
-- 
2.54.0

