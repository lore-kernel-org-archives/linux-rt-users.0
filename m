Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F655352C2C
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jun 2026 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781851142; cv=none; b=TBNxeKSYWTNNLgZKQ6hVO2T28mOSXPWFbsY5tbgni9yPQj1bEJRzTrhIbBb52mcU+mXZVfBPWWuVGn66J5ZKqFqgYE9NSApreNsW2nUsHa9tBLNYLiNP/tHvSQ0Lgqs/AlBl/jUCjlEjUnelF41QyQQGMtczOVq3cmNHOO7NwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781851142; c=relaxed/simple;
	bh=vvEv8N0ntanG3hywD/wFwtXDdPaXewWm1IRHcK8MMFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7mosBmRu35JEdLxdZM24UP6RwEQ7xwk9u+xqnb+ijhsMsKmQd/AC5rr/4hrUgU2knNfyHf20G68JhQERp2uazU6j9zeKIjlyI7SRWEJBX23E+cpnJM86ri+zwGqXu8iOFh06qVXWadua3gRInXspaw5pBUTCU4tkgu+6TiKR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPUQmUMf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V4Iow5kc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPUQmUMf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V4Iow5kc"
From: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781851137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nkTJhmT1DnLvWe1cFGeB/SdlmE9e123UdPrx+Kp+Hlw=;
	b=VPUQmUMfIDsEgL0lLzkhV1S0FiKtBeIiU3E7v3zdB1BMP3uRFqy6nOuIJjJQy81pev08/L
	i68KoK4aZuo2zxYtd7J82y00zcB5bXhSoyuVhhQXqVqc6RIhFiHwQ6IZhIMRXCax/mRhah
	kqiKY32pwpHG2gHKWwpc+f6HBoy7/vdZ/csMBfhVV6/FaXLNJ9ynYmPAa7Gd7IX669iyFb
	jARDraMJkNl/zaXrN/Z/VUdK7gLYFQXrz442Rtc7FOIbCR6XzMI/BcfzkE0sul/wcgRr3s
	JbSPzbL9BVS92MRzhSoDpb4wLir8ZV2USX+3+RW461FXBQvu8YX2SRbqSm8ClA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781851137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nkTJhmT1DnLvWe1cFGeB/SdlmE9e123UdPrx+Kp+Hlw=;
	b=V4Iow5kcNGjUsdI1QwoIro6a4UzRBTwSQ5eBlaouB/p+TyDujWj9lmNL8gwpnUB7recwBb
	13ynbaKUh5ypGeBQ==
To: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>, Chris White <chwhite@redhat.com>
Subject: Re: [PATCH 3/3] rt-tests: Add AGENTS.md guide for AI coding assistants
In-Reply-To: <20260617202059.217693-3-jkacur@redhat.com>
References: <20260617202059.217693-1-jkacur@redhat.com>
 <20260617202059.217693-3-jkacur@redhat.com>
Date: Fri, 19 Jun 2026 08:38:55 +0200
Message-ID: <874iizc9vk.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Jun 17 2026, John Kacur wrote:
> This guide is also useful for human developers new to the project.
>
> Add comprehensive documentation for AI coding assistants working on the
> rt-tests codebase. This guide covers:
>
> - Project overview and architecture
> - Core programs (cyclictest, hwlatdetect, pi_stress, etc.)
> - Shared library components and build system
> - Development guidelines including code style and checkpatch usage
> - Testing procedures and debugging tools
> - Common gotchas for real-time testing
> - Related projects in the RT ecosystem (rteval, tuna, rtla, rv)
> - Kernel documentation references
>
> The guide is designed to help AI assistants quickly understand the
> codebase structure, key patterns, and best practices when making
> changes to rt-tests.
>
> Python requirement set to 3.8+ based on language features used in the
> codebase.
>
> Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  AGENTS.md | 416 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 416 insertions(+)
>  create mode 100644 AGENTS.md
>
> diff --git a/AGENTS.md b/AGENTS.md
> new file mode 100644
> index 000000000000..d589fbfde0f5
> --- /dev/null
> +++ b/AGENTS.md
> @@ -0,0 +1,416 @@
> +SPDX-License-Identifier: GPL-2.0-only
> +
> +Copyright 2026 John Kacur <jkacur@redhat.com>
> +
> +# AGENTS.md - AI Coding Assistant Guide for rt-tests
> +
> +This document provides guidance for AI coding assistants working with th=
e rt-tests codebase.
> +
> +## Project Overview
> +
> +**rt-tests** is a collection of programs for testing real-time Linux ker=
nel behavior. These tools measure scheduling latency, test priority inherit=
ance, validate deadline scheduling, and stress-test various real-time featu=
res of the Linux kernel.
> +
> +- **License**: GPL-2.0-only (some files GPL-2.0-or-later)
> +- **Language**: C (with some Python utilities)
> +- **Maintainers**: John Kacur <jkacur@redhat.com>, Clark Williams <willi=
ams@redhat.com>
> +- **Repository**: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests=
.git
> +- **Mailing List**: linux-rt-users@vger.kernel.org
> +
> +## Architecture
> +
> +### Directory Structure
> +
> +```
> +rt-tests/
> +=E2=94=9C=E2=94=80=E2=94=80 src/                          # Source code =
organized by program
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 cyclictest/              # Cycli=
ctest program (main latency tester)
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 hackbench/               # Sched=
uler benchmark/stress test
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 hwlatdetect/             # Hardw=
are latency detector (Python)
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 pi_tests/                # Prior=
ity inheritance tests
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 pmqtest/                 # POSIX=
 message queue test
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 ptsematest/              # POSIX=
 semaphore test
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 queuelat/                # Netwo=
rk queue latency detector
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-migrate-test/         # RT mi=
gration test
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 sched_deadline/          # SCHED=
_DEADLINE tests
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 signaltest/              # Signa=
l latency test
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 sigwaittest/             # Signa=
l wait test
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 ssdd/                    # Stres=
s, Strain, Duty, Duration test
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 svsematest/              # SysV =
semaphore test
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 oslat/                   # OS la=
tency detector
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 backfire/                # Backf=
ire test utility
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 lib/                     # Share=
d library code
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-utils.c          =
 # Common utilities (affinity, prio, tracing)
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-numa.c           =
 # NUMA support functions
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-error.c          =
 # Error handling
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-sched.c          =
 # Scheduler utilities
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-get_cpu.c        =
 # CPU detection
> +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 histogram.c         =
 # Histogram generation
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 include/                 # Commo=
n header files
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-utils.h          =
 # Utility function declarations
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-numa.h           =
 # NUMA declarations
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-error.h          =
 # Error handling declarations
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-sched.h          =
 # Scheduler declarations
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 rt-get_cpu.h        =
 # CPU detection declarations
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 histogram.h         =
 # Histogram declarations
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 pi_stress.h         =
 # PI stress test definitions
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 pip_stress.h        =
 # PIP stress test definitions
> +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 bionic.h            =
 # Android Bionic support
> +=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 arch/                    # Archi=
tecture-specific code
> +=E2=94=82       =E2=94=94=E2=94=80=E2=94=80 android/             # Andro=
id-specific support
> +=E2=94=9C=E2=94=80=E2=94=80 Makefile                     # Build system
> +=E2=94=9C=E2=94=80=E2=94=80 README.markdown              # Usage documen=
tation
> +=E2=94=9C=E2=94=80=E2=94=80 MAINTAINERS                  # Maintainer co=
ntact information
> +=E2=94=9C=E2=94=80=E2=94=80 COPYING                      # License text
> +=E2=94=9C=E2=94=80=E2=94=80 Dockerfile                   # Container bui=
ld configuration
> +=E2=94=9C=E2=94=80=E2=94=80 get_pylib.py                 # Python librar=
y path helper
> +=E2=94=9C=E2=94=80=E2=94=80 feature/                     # Feature detec=
tion for build
> +=E2=94=94=E2=94=80=E2=94=80 bld/                         # Build output =
directory
> +```
> +
> +### Core Programs
> +
> +**cyclictest** - High-resolution timer latency tester (primary tool):
> +- Measures scheduling latency and timer jitter
> +- Multi-threaded with per-CPU thread support
> +- Integrates with kernel tracing (ftrace)
> +- Supports histogram output
> +- Can trigger trace on latency threshold (`--breaktrace`)
> +- Options for affinity, priority, interval, duration
> +- Man page: src/cyclictest/cyclictest.8
> +
> +**hackbench** - Scheduler stress test and benchmark:
> +- Creates groups of processes/threads exchanging messages
> +- Stresses scheduler and IPC mechanisms
> +- Useful for finding worst-case latencies under load
> +
> +**pi_stress / pip_stress** - Priority inheritance tests:
> +- Tests kernel priority inheritance mechanisms
> +- Validates priority ceiling protocol
> +- Helps debug priority inversion issues
> +
> +**pmqtest / ptsematest / svsematest** - IPC latency tests:
> +- Test POSIX message queues, POSIX semaphores, SysV semaphores
> +- Measure wakeup latency through various IPC mechanisms
> +
> +**hwlatdetect** - Hardware/firmware latency detector (Python):
> +- Detects System Management Interrupts (SMIs) and firmware delays
> +- Uses kernel hwlat detector module
> +- Runs in debugfs environment
> +
> +**queuelat** - Network queue latency detector:
> +- Measures latency caused by network queue processing
> +- Tests impact of network load on real-time performance
> +
> +**deadline_test / cyclicdeadline** - SCHED_DEADLINE tests:
> +- Test and validate SCHED_DEADLINE scheduler
> +- Deadline-based real-time scheduling
> +
> +**oslat** - OS latency detector:
> +- Detects OS-induced latencies
> +- Measures worst-case OS interference
> +
> +**signaltest / sigwaittest** - Signal latency tests:
> +- Test signal delivery latency
> +- Measure real-time signal performance
> +
> +**ssdd** - Stress, Strain, Duty, Duration:
> +- Configurable stress test with various patterns
> +- Tests system under different workloads
> +
> +**rt-migrate-test** - RT task migration test:
> +- Tests real-time task migration behavior
> +- Validates scheduler migration logic
> +
> +### Shared Library Components
> +
> +**rt-utils.c / rt-utils.h** - Common utilities:
> +- `parse_cpumask()` - Parse CPU affinity masks
> +- `numa_initialize()` - Initialize NUMA support
> +- `enable_trace_mark()` - Enable kernel trace markers
> +- `tracemark()` - Write trace markers
> +- `get_tracers()` - Get available kernel tracers
> +- `setkfifo()` - Set SCHED_FIFO priority
> +- Priority, affinity, and tracing helpers
> +
> +**rt-numa.c / rt-numa.h** - NUMA support:
> +- CPU topology detection
> +- NUMA node management
> +- Per-node thread allocation
> +
> +**rt-error.c / rt-error.h** - Error handling:
> +- `fatal()` - Fatal error with exit
> +- `err_exit()` - Error with errno
> +- `warn()` - Warning messages
> +- `info()` - Informational messages
> +
> +**histogram.c / histogram.h** - Latency histogram generation:
> +- Collect latency samples into bins
> +- Format histogram output
> +- Calculate statistics (min, max, avg)
> +
> +**rt-sched.c / rt-sched.h** - Scheduler utilities:
> +- Scheduler policy helpers
> +- Priority validation
> +
> +**rt-get_cpu.c / rt-get_cpu.h** - CPU detection:
> +- Get current CPU number
> +- CPU affinity helpers
> +
> +### Python Utilities
> +
> +**hwlatdetect.py** - Hardware latency detector:
> +- Detects SMIs and firmware-induced delays
> +- Mounts/unmounts debugfs as needed
> +- Uses kernel's hwlat_detector module
> +- Supports duration, threshold, and window parameters
> +
> +**get_cyclictest_snapshot.py** - Cyclictest snapshot utility:
> +- Captures cyclictest state while running
> +- Reads /dev/shm/cyclictest-* files
> +- Provides statistics and thread status
> +
> +**get_pylib.py** - Python library path helper:
> +- Determines correct Python library installation path
> +- Used by Makefile for Python tool installation
> +
> +## Development Guidelines
> +
> +### Code Style
> +
> +- Follow Linux kernel coding style (K&R style)
> +- Use tabs for indentation (width 8)
> +- Maximum line length: 80 characters
> +- SPDX license identifier at top of each file: `// SPDX-License-Identifi=
er: GPL-2.0-only`
> +- Function names: lowercase with underscores (e.g., `parse_cpumask`)
> +- Variable names: lowercase with underscores
> +- Constants: UPPERCASE with underscores
> +- **Checking code style**: Use the kernel's checkpatch.pl script to veri=
fy code style compliance:
> +  ```bash
> +  /path/to/kernel/scripts/checkpatch.pl --no-tree -f <file.c>
> +  ```
> +
> +### C Standards and Dependencies
> +
> +- **C Standard**: C99 or later
> +- **POSIX**: POSIX.1-2001 with real-time extensions
> +- **Required Libraries**:
> +  - pthread (POSIX threads)
> +  - rt (POSIX real-time extensions)
> +  - numa (NUMA support, optional)
> +  - dl (dynamic loading)
> +- **Optional Libraries**:
> +  - cpupower (for deepest idle state support)
> +
> +### Python Code
> +
> +- **Python Version**: Python 3.8+
> +- **Style**: PEP 8 Python style guide
> +- **Shebang**: `#!/usr/bin/python3`
> +- Use standard library modules when possible
> +- Include docstrings for modules, classes, and functions
> +
> +### Error Handling
> +
> +- Use `err_exit()` for fatal errors with errno
> +- Use `fatal()` for fatal errors without errno
> +- Use `warn()` for warnings that don't stop execution
> +- Check return values from all system calls
> +- Handle interrupted system calls (EINTR)
> +- Clean up resources (threads, memory, file descriptors) on error
> +
> +### Real-Time Programming Considerations
> +
> +1. **Memory Locking**: Lock memory with `mlockall(MCL_CURRENT | MCL_FUTU=
RE)` to prevent page faults
> +2. **Priority**: Use SCHED_FIFO or SCHED_DEADLINE for real-time threads
> +3. **Affinity**: Pin threads to specific CPUs to avoid migration overhead
> +4. **Stack Prefault**: Touch stack pages before real-time operation
> +5. **Avoid Blocking**: Minimize system calls and library calls in RT cri=
tical sections
> +6. **Signal Handling**: Use real-time signals when possible
> +7. **Trace Integration**: Support ftrace integration for latency debuggi=
ng
> +
> +## Build and Installation
> +
> +### Build Commands
> +
> +```bash
> +# Install build dependencies (Debian/Ubuntu)
> +sudo apt-get install build-essential libnuma-dev
> +
> +# Install build dependencies (Fedora/RHEL)
> +sudo dnf install gcc make numactl-devel kernel-tools-libs-devel
> +
> +# Build all programs
> +make
> +
> +# Build with debugging
> +make DEBUG=3D1
> +
> +# Build specific program
> +make cyclictest
> +
> +# Clean build artifacts
> +make clean
> +
> +# Generate tags
> +make tags
> +```
> +
> +### Installation
> +
> +```bash
> +# Install to /usr/local (default)
> +sudo make install
> +
> +# Install to custom prefix
> +sudo make prefix=3D/usr install
> +
> +# Install with compressed man pages
> +sudo make MAN_COMPRESSION=3Dgzip install
> +```
> +
> +### Cross-Compilation
> +
> +```bash
> +# Set cross-compiler
> +make CROSS_COMPILE=3Daarch64-linux-gnu-
> +
> +# Build for Android
> +make ostype=3Dandroid
> +```
> +
> +## Testing
> +
> +### Running cyclictest
> +
> +```bash
> +# Basic test: one thread per CPU, SCHED_FIFO priority 99
> +sudo ./cyclictest -a -t -p99
> +
> +# With histogram output
> +sudo ./cyclictest -a -t -p99 -h 400 -q
> +
> +# With trace on latency spike
> +sudo ./cyclictest -a -t -p99 --tracemark --breaktrace=3D100
> +
> +# Long duration test (24 hours)
> +sudo ./cyclictest -a -t -p99 -D 24h -h 400 -q
> +```
> +
> +### Running hwlatdetect
> +
> +```bash
> +# Detect hardware latency for 60 seconds
> +sudo ./hwlatdetect --duration=3D60
> +
> +# With threshold
> +sudo ./hwlatdetect --duration=3D60 --threshold=3D10
> +```
> +
> +### Testing Priority Inheritance
> +
> +```bash
> +# Run pi_stress test
> +sudo ./pi_stress
> +
> +# Run with specific parameters
> +sudo ./pi_stress --inversions=3D100 --duration=3D60
> +```
> +
> +## Key Files
> +
> +- `src/cyclictest/cyclictest.c` - Main latency testing tool
> +- `src/lib/rt-utils.c` - Common utility functions
> +- `src/lib/rt-numa.c` - NUMA support
> +- `src/include/rt-utils.h` - Utility declarations
> +- `src/hwlatdetect/hwlatdetect.py` - Hardware latency detector
> +- `Makefile` - Build configuration
> +- `README.markdown` - Usage documentation
> +
> +## Common Gotchas
> +
> +1. **Root Privileges**: Most tests require root to set real-time priorit=
ies and lock memory
> +2. **Kernel Configuration**: RT tests require kernel with CONFIG_PREEMPT=
_RT or CONFIG_PREEMPT for best results
> +3. **CPU Isolation**: For accurate results, isolate CPUs from scheduler =
(isolcpus kernel parameter)
> +4. **Power Management**: Disable CPU frequency scaling and idle states f=
or consistent results
> +5. **NUMA Systems**: Be aware of memory locality on NUMA systems
> +6. **Tracing Overhead**: Kernel tracing adds overhead; use only when nee=
ded
> +7. **Signal Handling**: Proper cleanup on SIGINT/SIGTERM is important
> +8. **Memory Locking**: Must lock memory before enabling real-time priori=
ty
> +
> +## Build System Notes
> +
> +The Makefile uses feature detection to conditionally enable features:
> +
> +- **libcpupower**: Detected via feature/test-feature.mak, enables `--dee=
pest-idle-state` option
> +- **NUMA**: Detected at build time, links with libnuma if available
> +- **Python**: Detected via get_pylib.py, determines if Python utilities =
can be installed
> +- **Architecture**: Detected via `$(CC) -dumpmachine` for platform-speci=
fic code
> +
> +### Makefile Variables
> +
> +- `VERSION`: Current version number
> +- `DESTDIR`: Installation destination (for packaging)
> +- `prefix`: Installation prefix (default: /usr/local)
> +- `DEBUG`: Enable debug build (DEBUG=3D1)
> +- `CROSS_COMPILE`: Cross-compiler prefix
> +- `no_libcpupower`: Disable libcpupower (no_libcpupower=3D1)
> +
> +## Support and Contact
> +
> +- **Maintainers**:
> +  - John Kacur <jkacur@redhat.com>
> +  - Clark Williams <williams@redhat.com>
> +- **Mailing List**: linux-rt-users@vger.kernel.org
> +- **Bug Reports**: Send to maintainers with mailing list CC'd
> +- **Patch Submissions**: Send to maintainers with mailing list CC'd
> +
> +## Git Workflow
> +
> +- **Main Branch**: `master`
> +- **Repository**: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests=
.git
> +- **Patch Submission**: Use standard git format-patch/send-email workflow
> +- **Commit Format**: Follow kernel commit message format
> +
> +### Development Workflow
> +
> +1. Make changes to code
> +2. Build and test: `make && sudo ./cyclictest -a -t -p99`
> +3. Run relevant tests to verify changes
> +4. Update man pages if changing command-line options
> +5. Commit with descriptive message
> +6. Submit patches to maintainers with mailing list CC'd
> +
> +## Additional Notes for AI Assistants
> +
> +1. **Real-Time Focus**: All programs are designed for real-time system t=
esting and analysis
> +2. **Kernel Integration**: Heavy integration with Linux kernel features =
(ftrace, debugfs, scheduler)
> +3. **Thread Safety**: Most programs are multi-threaded; be aware of sync=
hronization
> +4. **Signal Handling**: Programs must handle SIGINT/SIGTERM for graceful=
 shutdown
> +5. **Resource Cleanup**: Always clean up threads, memory, and file descr=
iptors
> +6. **Man Page Updates**: Update man pages when changing options or behav=
ior
> +7. **Backwards Compatibility**: Maintain compatibility with existing scr=
ipts and tools
> +8. **Performance Critical**: Some code paths are performance-critical; a=
void adding overhead
> +9. **Architecture Support**: Code should work on x86_64, aarch64, ppc64l=
e, s390x, RISC-V
> +10. **Android Support**: Some programs support Android via Bionic compat=
ibility layer
> +
> +## Related Projects
> +
> +Projects in the RT ecosystem:
> +
> +- **rteval**: Real-time evaluation suite - https://git.kernel.org/pub/sc=
m/utils/rteval/rteval.git
> +- **tuna**: Thread and IRQ tuning tool - https://git.kernel.org/pub/scm/=
utils/tuna/tuna.git
> +- **rtla**: Real-time Linux analysis tool - https://www.kernel.org/doc/h=
tml/latest/tools/rtla/
> +- **rv**: Runtime verification tool - https://www.kernel.org/doc/html/la=
test/tools/rv/
> +- **Linux RT Kernel**: PREEMPT_RT patches - https://kernel.org/pub/linux=
/kernel/projects/rt/
> +
> +## References
> +
> +- **Linux Real-Time Wiki**: https://wiki.linuxfoundation.org/realtime/st=
art
> +- **OSADL Latency Plots**: https://www.osadl.org/QA-Farm-Realtime.qa-far=
m-about.0.html
> +- **RT Kernel Documentation**: https://www.kernel.org/doc/Documentation/=
scheduler/sched-rt-group.txt
> +- **High-resolution timers**: https://www.kernel.org/doc/html/latest/tim=
ers/hrtimers.html

Sebastian also added a complete documentation guide for PREEMPT_RT:

 https://docs.kernel.org/core-api/real-time/index.html

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJSBAEBCgA8FiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmo04/8eHGt1cnQua2Fu
emVuYmFjaEBsaW51dHJvbml4LmRlAAoJEMGT0fKqRnOCWa0P/0EOO19He7UYld1i
i0VQ93eV6/1tnCNsTTcVT3D+6F3ORsxyiiUl/7g73u/w4nKO2N0zpjR9xNOlFpL/
pYjgaYqSTjzkC9MNpzWyigc5CtkFuIbUrImFkQOdKyFxApCah88PcrG/+9XsIZiY
omS2TtTsBwxaAMGVaWdBg8cTmFKP7I8z3rf5y0TmcD7Fel26is7WwSye8soggqMv
KDJJ7WsKHduDLG1maxs4UARFfS4kESKv5MBjcn6l7e3Ll9y7by/WJ70HjmGW5SDl
fZJcPnJVawkRQ2a0ctpYZYKAGKbuVD0U6OGbriUHxuSyGG9HiH445Pu1Z9OVV/+/
jYNXTPWB/aZOSV0laqD6jZSQkgpqCP1DqvsI2cNNgpRvdihH+Tf7MZ3ih6MOjOQS
3rIsWuVqwyjhCEI6coEfUhFvwbKm2kATCu7a7zBGPy4MVY1JBGcd76ymagn9hejf
rFDuclmR0MFjeTD5WodWRe6o+TzhFtJMe53MKcIkrE+c8ZUx5KsD1KrnGlwUJ5HK
XU//EP/gykEEvhrvHwIsvUfblUieolbPJiIw4qCXiiEhU+zJGLe9cU72qKIuY8k8
3GE7RncZG0YRVzPlnel9AFPw+M0CblI4kp84IUcPFDqkTw1gJ6jdz7xtjRx4l3pC
AsWJDdiTXxn6XSgL+23MjLKS7RXr
=Oh4g
-----END PGP SIGNATURE-----
--=-=-=--
