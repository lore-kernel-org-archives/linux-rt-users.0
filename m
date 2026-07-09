Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636D3AD535
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jul 2026 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592910; cv=none; b=OR5nJpepzLrY64XDPbvaSHFaNKCCz+7jjUqhbvH52Dzzkt5iPSi5WsLruqZYQB0k3Wh19LAUE28WkMmOpjW4DVJ/40IKfnVQzKIZqYD+SFESq3Hg761kjJwl/JoXlOZaN3/prgaq7mqA9tfBht29aJnqOo/ZjLWiTvX/VW8qwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592910; c=relaxed/simple;
	bh=O82k8NBM2T0MGn088o59fFFmDSGkWZtWB3WzxD0+6Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kk9pZTqXAGn4yb5l6m2K0n5sc2qFUOfk6NUMH0lCPcF3tgCyMztg2F3LpGPcUADUH0efU0U5TUKDQTfVky7wuPv22Q4dbknVTW74LPKLW/yHL1cxKeS9MexYXrqxxy9N8+mvL3yBc6x/TjO3/Rh6C3oAQAw0ZOpkxWWPFhHVD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHE7GxSy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WrBrPP1r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHE7GxSy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WrBrPP1r"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783592906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VI67Uk2SLhnCPxtbbhO8FYbt09SlwdVYYDVFArVRSKQ=;
	b=NHE7GxSy1wr03Q97gd8Ip7/q9+9fYl3MRue6im9/ffKcicelLMwR0tY9e8D/MCWrQ4ZZjD
	qSnz3MSg0reXaS/z7Cjj3rv9FIO9vIO5CsoR01E5k91H+otI04pLM0vl0yE2IDxK+FFAuL
	Rqt5OU2G+c169cNUHfSQDT9cj7XAimF63TCvg3vAL1qevUgl4yfNFnbi/bB5whJ5S4ZN1M
	zxwJEJI1OHiUHLvzOhPIYYSN7Nz39+qqopTK4HdAOD0vGWgmS5wnTftt0tt8+mZnXRBW/m
	iFVuT/ze1y608BTcP0tA2ECr9lN2dDENRX8UsVeQgAd+g0Z4Pt50s8KtXp6DEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783592906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VI67Uk2SLhnCPxtbbhO8FYbt09SlwdVYYDVFArVRSKQ=;
	b=WrBrPP1r3IeS/BjVNn8cz37JRFnHp/AwD1QugILuh09EACdD80eTS6qevdLS+UE/oO5gNc
	Z/D5AxFZDhIHSjDA==
To: rt-users <linux-rt-users@vger.kernel.org>
Cc: Song Yoong Siang <yoong.siang.song@intel.com>, Chwee-Lin Choong
 <chwee.lin.choong@intel.com>, "Zage, David" <david.zage@intel.com>,
 "Oehrlein, Scott" <scott.oehrlein@intel.com>, "Blanco Alcaine, Hector"
 <hector.blanco.alcaine@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Gavin Lai
 <gavin09@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, "Schreckenberg, Lukas"
 <lukas.schreckenberg@iosb-ina.fraunhofer.de>
Subject: [ANNOUNCE] RTC-Testbench v5.5
Date: Thu, 09 Jul 2026 12:28:24 +0200
Message-ID: <87bjcgqwxj.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hello RT-list!

I'm pleased to announce version v5.5 of the Linux RTC-Testbench.

Release notes:

 - Extend workload interface: Multiple threads, traffic classes,
   non-x86 etc. -> Useful for PLC simulation
 - Add support for auxiliary clocks and add multi domain PTP testcases
 - Add napictl tool to configure napi_defer_hard_irqs and gro_flush_timeout
   per queue instead per interface
 - Add Intel KPI tests from Song Yoong Siang and Chwee-Lin Choong
 - Bugfixes from Song Yoong Siang and Chwee-Lin Choong
 - Included in Debian by Gavin Lai

Thanks to all contributors.

You can get the code and documentation via the git tree at:

  https://github.com/Linutronix/RTC-Testbench

Thanks,
Kurt

Shortlog v5.4..v5.5:

Chwee-Lin Choong (3):
      build: Fix minimum libxdp version for AF_XDP TX timestamp support
      stat: Fix rx latency averages using dedicated rx_count
      xdp: Fix TX HW timestamp correlation by frame sequence

Kurt Kanzenbach (156):
      napictl: Add tool to configure netdev NAPI instances
      tests: Add another function for napi_defer_hard_irqs
      tests: Add test case for napictl
      README: Remove ToDo about busy polling conf
      tests: Remove references to platforms
      pointer_chasing: Get rid of CamelCase
      utils: Fix leak of file descriptor
      log/buffer: Adjust sizeof() parameter
      workload: Make setup function static
      workload: Adapt Testbench coding style
      workload: Remove unused function
      workload: Add error handling for argc/argv handling
      workload: Add error handling for workload init
      tsn: Check for workload init failures
      workload: Add const to strings
      workload: Free allocated argc/argv vectors
      workload: Check return code of setup function
      workload: Redo workload locking
      workload: Check return code of workload function
      workload/readme: Move README to documentation
      workload/readme: Move ptr chasing README to documentation
      tools: Test RX_TIMESTAMP for Ubuntu
      ptr_chasing: Adapt Testbench coding style
      ptr_chasing: Actually use CACHE_LINE_SIZE
      ptr_chasing: Change type of run_ptr_chasing()
      ptr_chasing: Keep local functions static
      ptr_chasing: Remove log_message() calls
      ptr_chasing: Add error handling to setup_func()
      ptr_chasing: Free allocated buffer as well
      ptr_chasing: Add generic C version
      rtworkload: Change interface
      rtworkload: Adjust priority of workload thread
      tsn/rtc/rta: Fix error handling for early failures
      jacobi_2d: Add another workload example
      all: Update copyright info to 2026
      config: Only print config value for active settings
      tools: Include workload examples in Q/A test
      log/stat: Adjust tracing paths
      profinet: Split Profinet specific code from utils
      utils: Fix EtherType for insert_vlan_tag()
      workload: Move Rx/Tx hooks to workload code
      tsn: Enable workload code also for reference app
      tsn: Enable workload code for AF_PACKET
      rtc: Enable workload code
      l2: Enable workload code
      doc: Update workload configuration options
      tests: Enable pointer chasing workload also on reference side
      log: Fix build warning
      thread: Add missing include
      config: Fix new lines
      stat: Send RxWorkloadOutliers also to MQTT/JSON
      stat: Add error messages to fopen() calls
      stat: Fix json encoding
      stat: Use double type for logging
      thread: Move name generation into thread create function
      utils: Move snprintf error handling to utils
      log: Add correct error handling to snprintf
      stat: Change object name in JSON messages
      log: Pad timestamps with zero instead of spaces
      config: Add code for parsing CPU lists
      stat: Allocate statistics for up to X workload threads
      workload: Introduce a teardown function
      workload: Introduce workload instances
      workload: Move common tasks into init function
      workload: Add cleanup functions
      workload: Allow to run multiple workload threads
      log: Print statistics for all workload threads
      stat: Add JSON statistics for all workload threads
      config: Print CPU list
      tests: Add testcase for multiple instance workload
      doc: Update workload documentation
      jacobi_2d: Initialize grid with random numbers only once
      ptr_chasing: Rename workload function
      elbe: Add tools like bpftool and xdp-tools
      log: Prefix clock_nanosleep() error messages
      log: Add missing newlines to clock_gettime() error messages
      config: Allow to specify auxiliary clocks
      tests: Add testcase for working clock
      doc: Update available clock ids
      doc: Add description for working clock test case
      config: Allow CLOCK_REALTIME as application clock
      doc: Document CLOCK_REALTIME
      all: Check return value of clock_gettime()
      stat: Record OneWay time as signed int
      utils: Rename mirror Tx timestamp function
      utils: Add precise mirror Tx timestamping
      tests: Add test scenario for ER 2026
      tests: Add another GT/WC test case
      tests: Compile phc2sys/ptp4l for aux clocks
      tests: Add test case for explicitly for i210
      doc: Add documentation for second working clock test case
      README: Remove ToDo about Debian packaging
      tests: Add another working clock test case
      scripts: Add script to check Linux kernel configuration
      doc: Mention third working clock test case
      doc: Mention the kconfig checker tool
      tests: WC: Compile linuxptp from upstream
      scripts: kconfig: Explicitly name CLS options
      scripts: kconfig: Add VLAN and virtual Ethernet
      doc: Update kernel version for clock_nanosleep() for AUX clocks
      doc: Update references to phc2sys patches
      log: Add error handling for snprintf()
      net: Fix error message in create_rta_socket()
      net: Fixup error message
      all: Remove or annotate unused parameters
      thread: Annote fall throughs in switch case statement
      utils: Fix iv initialization warning
      cmake: Enable Wextra
      napictl: Fix parsing/sign compare issues
      scripts: Add ptp_log script
      telegraf: Add MQTT consumer for PTP data
      xdp: Reduce code duplication
      ci: Extend build script to cover all combinations
      all: Fix warning about missing field initializers
      security: Fix error handling in init() function
      mqtt: Cleanup mosquitto context only once
      config: Use enum in config_is_traffic_class_active()
      stat: Update stat_frame_type_to_string() to use l2->tc_name
      ref/mirror: Move common code to single module
      cmake: Fix options for MQTT and ASAN
      tests: Add unit test for ring buffer
      rb: Document how the ring buffer should behave
      rb: Make the code readable
      rb: Set out_len in ring_buffer_fetch()
      rb: Implement drop oldest policy correctly
      github: qa: Add cmocka as dependency
      tools: qa: Run unit tests
      xdp: Refcount the XDP program
      xdp: Fix error handling in xdp_open_socket()
      packet/udp: Do not continue on errors
      stat: Free already allocated memory in case of errors
      net: Add a macro to generate Profinet BPF filters
      net: Introduce a single function to create sockets
      config: Fix missing ret initialization in case of errors
      config: Set key to NULL in config
      config: Fix CPU list parsing
      utils: Fix check for closing the latency fd
      config: Switch RxWorkloadSkipCount to unsigned
      workflows: Upgrade to Ubuntu 26.04
      workflows: Build all configurations
      reuse: Upgrade config from dep5 to REUSE.toml
      scripts: Add busy poll kernel configuration
      doc: Document how to run the unit tests
      doc: Remove outdated limitation
      doc: Update workload configuration options
      doc: Update the build section
      udp: Add missing default case
      udp: Add missing conversion to app_clock_get()
      xdp: Use correct function to access frame_id
      xdp: Do not OR into uninitialized memory
      ci: Remove old ubuntu limitation
      Add AGENTS.md for AI coding assistants
      scripts: Format Perl with perltidy in Linux kernel style
      pre-commit: Enable clang-format and perltidy
      doc: Add napictl tool documentation
      Release version v5.5

Song Yoong Siang (7):
      stat: Add outlier tracking for processing latency
      stat: skip outlier detection for initial rx workload measurements
      igc: Explicitly disable Energy Efficient Ethernet (EEE)
      tests/intel_kpi: Add i226 XDP 1ms test with asymmetric RX workload
      tests/intel_kpi: Add i226 XDP 125us test with PTP hardware timestamp
      tests/intel_kpi: Add i226 XDP 1ms test with PTP hardware timestamp
      tests/intel_kpi: disable XDP busy polling for i226 processing-latency tests

dependabot[bot] (5):
      build(deps): bump actions/cache from 4 to 5
      build(deps): bump awalsh128/cache-apt-pkgs-action from 1.6.0 to 1.6.1
      build(deps): bump actions/checkout from 6 to 7
      build(deps): bump actions/cache from 5 to 6
      build(deps): bump awalsh128/cache-apt-pkgs-action from 1.6.1 to 1.6.3

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmpPd8gTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgiU0D/49lbeN8af7e0FyHUlKoD6F1rNnX89m
bLDLfxm2vjbJgpSYqFsIK/5ysK4OvfOwk83c1zz5+/t7a8Rj4TCrx02Jlp6n2cyY
kl1sstbV0kmeBXcpiHuQbnbAI/iiutpQnCq5PcXHn89fuCFSC+5gAKwSnaJNCI2A
8CfcWJSdlpw3i1nynYEh5S/ZCHShVd7XjofoLp/FsRgGXVtx5mwJ9kZ3LEB4jGSH
YDQoo8AWVay3RM2AlPvwpu+FhdWMg4bJAwq55YFf0MV39VsjiLjljhR5/vnofY5d
wIjlIWbODsHMfppJgNZuTqPjlpKkFCVTrp3luQ8h3mn7MySQTywWD1fCmcO8Owi1
Du9VA4LeStAiYdLqS0R7YT2hsgiBBbf1+hq5ij357JlRznQl9Ly0SvkdsTJqod3W
HjAC4SX3UUBqQ4UAVPz1n2MS0gTidfp1L/LbcxDwTPEyOW24ShUYCoFkRgvH0RZp
2RIDqUMqLhdZuCWACq34C+bJZwu2oGbk0ApC0Dk6oUOX4kAX1ZsHNa9r7+rJx4vy
zN9Ss/CEAPV/KmLIWegzOTwlY1BUbgRM017lM0HHnXs6yZb1Z/n9ppsHRAjSUqar
7K1OuHckpFDkIWwShJ8SkhtnEuuBmNqe4JjpteiPsmxPD/8kIebJfpJk+zpnS3vN
cxTtksH6peMhPA==
=OOv7
-----END PGP SIGNATURE-----
--=-=-=--
