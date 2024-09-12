Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CF126C16
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Sep 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132523; cv=none; b=BkurUMTPp0ALdEDDsinYfyFHpX9hMeYny0iPErr2IJZZa1QCukJzm05OXqGgHd6qhGKNYyJrKVeoWPuVlU59dI9AzIbMx8L9HGpN5+TLXBkZTpIsRVUIZ26i9v9EHEmLo+5ZIaMkumuTQnU9tSr9qKFQlNa68V01x1l9NzIfBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132523; c=relaxed/simple;
	bh=7vttiZPdNbKSdVM04qt5NM0aZ3jL0bd2DkAisRloV3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJGYbYyiB4HSskNUHf/cYIq7nQIQvU7GIZFQ9KdxgNlDjTrztPZWLshQgtGUqGkdoS9r+PXQ3w3t7PGFzkMhYDC0AsD38a2IGk/HuOsexEndNzZXfsQzumwXOyCrueQdwOEe2G2IIlgUnPNu0KffhTzo/0gfaFRzdJqQM4wuNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwRXg9bh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hEbrAPHc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwRXg9bh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hEbrAPHc"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726132514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5Ljq1cVpbQbFMbnAqM3bXB/7xkAQA9xKU4OUUnbzDWY=;
	b=XwRXg9bhwZk/iAuKPPGgzaP40qux5F2IhuQmlbu4LY3JO3UP3x8KPIufE/BpsaShnoetr+
	JhAVzyFyfa3nneQ//vsJyUEB1A2GW0cxw78P7zjWiH6zoqZ3SqrJ11069+MHPXU4P5bESx
	x4kNdpmx+3i3yXCD+2a5705Z2211mRbf+VLoyIvSxubrT/9GtBwTHSmMsa6bd660hWR/E8
	Hz4Hv4tHiTH5oBecQN9IoFW9vdDEHmKAXGeZ1nxs9VwsGKb7rSRFudCKKXunIBuI7pgK1T
	5R9AeDbUtNPiK6Smzzki9K9f2BOnaGXqaHM57PXf71gcfVQYAFFgxVBVdMpEZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726132514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5Ljq1cVpbQbFMbnAqM3bXB/7xkAQA9xKU4OUUnbzDWY=;
	b=hEbrAPHcbxwiLS3Chrh0FMBrCvbwY1uoioS2yhVHM4eWiock2ud+XQ3xzdlO6rUGBuSsp0
	9RaCbgJCR6w9X7BQ==
To: rt-users <linux-rt-users@vger.kernel.org>
Cc: "Tedeschi, Walfred" <walfred.tedeschi@intel.com>, "Mildner, Alexander"
 <alexander.mildner@intel.com>, "Blanco Alcaine, Hector"
 <hector.blanco.alcaine@intel.com>, Pablo Iranzo =?utf-8?Q?G=C3=B3mez?=
 <Pablo.Iranzo@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] TSN-Testbench v5.0
Date: Thu, 12 Sep 2024 11:15:08 +0200
Message-ID: <87ttelp71f.fsf@kurt.kurt.home>
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

Hello RT-list!

I'm pleased to announce version v5.0 of Linux TSN Testbench.

Highlights:

 - Grafana visualization/dashboard for statistics, multiple instances, ...
 - Extend statistics e.g., measure one way latency, jitter, ...
 - Speed up AF_PACKET communication
 - Add tests for Intel i210 and NXP imx93
 - Bugfixes

Thanks to all contributors, especially to Fred for contributing the
Grafana part and Sebastian for code review.

You can get the code and documentation via the git tree at:

  https://github.com/Linutronix/TSN-Testbench

Thanks,
Kurt

Shortlog v4.0..v5.0:

Kurt Kanzenbach (170):
      stat: Simplify statistics functions
      stat: Account errors in statistics
      readme/doc: Update introduction and motivation
      cmake: Increase minimum version to v3.5
      tests: profinet_rt: Add a configuration for polling without qbv
      doc: Rename to TSN-Testbench
      doc: Switch to RTD theme
      doc: Use note annotation for notes
      doc: Update note about busy polling
      doc: Add descriptions for traffic classes
      doc: Update note about PROFINET security
      doc: Mention the possible link speed
      doc: Replace abbreviations
      doc: Import built html directory
      doc: Move html directory to /docs
      doc: Add nojekyll file
      README: Add link to documentation
      README: Add Siemens and Intel to credits
      README: Add a ToDo section
      tsn/rtc/rta: Remove dead stores
      tsn/rtc/rta: Fix payload check for encrypted frames
      README: Add feature list
      doc: Document TxTime options
      doc: Add image about task scheduling to example
      docs: Sync for Github
      tools: Add a build script
      docs: Sync for Github
      README: Update copyright
      config: Move '\n' back to correct position
      stat: Use frameType name in debug messages
      mqtt: Prefix onConnect()
      scripts: ehl: Adjust base time
      scripts: ehl: Disable Rx vlan offloading
      lldp/udp: Fix sequence counter comparison
      net: Don't leak socket file descriptor
      net: Use correct error reporting method for getaddrinfo()
      net: Return error in error case
      config: Add missing NULL check
      tsn/udp: Avoid leaking of thread configs
      tests/imx93: Add PROFINET test for imx93
      doc: Rename TSN-Testbench
      config: Remove Tx/Rx enabled flags
      yaml: Remove all references to <Class>Tx|RxEnabled
      doc: Remove <Class>Tx|RxEnabled documentation
      config: Introduce new enabled flags
      yaml: Add new <Class>Enabled fields
      doc: Document <Class>Enabled flags
      ref/mirror: Make configuration mandatory
      README: Add maintainer info
      README: Move resources section after description
      docs: Sync for Github
      license: Add license file
      doc: Add contributing guidelines
      doc: Add issue template
      README: Link to the contribution guide lines
      README: Update link to contributing guide lines
      all: Use reverse xmas tree convention consistently
      doc: mqtt: Remove trailing whitespaces
      mqtt: Move the NULL check
      clang-format: Switch coding style to Linux kernel
      clang-tidy: Add a configuration for clang-tidy
      all: Convert coding style to Linux kernel
      all: Convert CamelCase to snake_case
      all: Run clang-format again
      config: Adjust configuration file parsing
      doc: Update the coding style
      doc: Add clang-tidy to QA
      doc: Mention email contributions
      sec/mqtt: Fix SPDX style comment
      log/mqtt: Use void where possible
      config: Use correct printf modifier for uint64_t
      docs: Sync for Github
      yaml: Fix spelling of LldpEnabled
      emacs: Fix dir-locals.el
      log: Reduce memory consumption
      stat: Reduce memory consumption
      all: Unify comment style
      tools: Add a qa script
      tests/busypolling: Increase to 256 frames
      README: Add more ToDos
      docker: Build application from source
      l2: Remove superfluous +
      doc: Update busy polling scenario
      doc: Add quick start guide
      doc: Mention the contributing guide lines
      docs: Sync for Github
      tests/busypolling: Do not ignore Rx errors
      tests/busypolling_8ms: Add new busypolling test
      README: Add more ToDos
      doc: Mention the imx93
      rtc/rta/dcp: Stick to reverse xmas tree
      all: Switch AF_PACKET/UDP code to polling
      tests/multi_middleware: Adjust to Debian 12/Kernel v6.1
      xdp: Remove empty line
      tests/profinet: Add a PROFINET test for AF_PACKET
      doc: Document the PROFINET AF_PACKET test
      docs: Sync for Github
      l2: Reduce number of system calls
      tests/opcua: Add a OPC/UA test with AF_PACKET
      all: Unify frame sizes
      all: Replace malloc() + memset() with calloc()
      thread: Move g2_idx() to thread
      tsn/rtc/rta: Use frame_idx where possible
      stat: Inline stat_frame_type_to_string()
      tsn: Get rid of sprintf() in tsn_send_message()
      udp: Save traffic class as well
      all: Prefix all log messages
      tsn/rtc/rta: Introduce dedicated payload pattern for AE
      cmake: Align indentation
      README: Extend ToDo list
      packet: Move packet sending into its own module
      packet: Move packet receiving into its own module
      tsn: Switch to sendmmsg() and recvmmsg()
      rtc: Switch to sendmmsg() and recvmmsg()
      rta: Switch to sendmmsg() and recvmmsg()
      lldp: Switch to sendmmsg() and recvmmsg()
      dcp: Switch to sendmmsg() and recvmmsg()
      l2: Remove redundant function parameters
      issue-template: Mention Linux kernel and distribution
      README: Remove ToDo for AF_PACKET
      all: Get rid of Variable Length Arrays (VLA)
      packet: rx: Get rid of Variable Length Arrays (VLA)
      utils: Add generic function for sequence counter handling
      all: Use generic sequence counter functions
      packet: tx: Get rid of Variable Length Arrays (VLA)
      cmake: Enable VLA warnings
      all: Implement clean shutdown
      config: free() is NULL safe
      all: Fix memory leaks
      all: Remove unused stop() functions
      README: Remove clean shutdown from ToDo list
      configurations: Remove them all
      doc: Update references to samples/tests
      doc: Add debug section
      docs: Sync for Github
      rtc/rta: Remove unused function parameters
      ref/mirror: Remove reference to deleted directory
      tests/busypolling_125us: Add new busy polling test
      tests/busypolling_250us: Add new busy polling test
      docs: Sync for Github
      tests/busypolling_sp: Add new busy polling test
      scripts: Add script to trace CPU run times
      tests/busypolling_i210: Add new busy polling test
      stat: Simplify debugging of outliers
      stat: Remove unnecessary else branch
      tests: Update debug options
      doc: Update Debug options
      README: Remove ToDo about mirror debugging
      docs: Sync for Github
      stat: Close trace marker file first
      github: Add build workflow
      config: Make the PCP values configurable
      all: Use PCP values from configuration
      doc: Document new PCP options
      rta/dcp/lldp/udp: Do not run TxGen threads on mirror side
      rtc/rta/dcp/lldp/udp: Always signal next Tx thread
      all: Switch to reuse for checking licenses and copyrights
      xdp: Update SPDX identifier
      reuse: Add license/copyright information
      doc: Update QA page
      scripts: Add automatic license/copyright checking
      github: Add QA workflow
      doc: Document UDP communication
      reuse: Add files for label workflow
      tests: Relocate multi middleware test
      tests: Add i226 multi middleware test
      scripts: Add script to adjust existing config files
      packet: Assign control before referencing it
      packet: Pass valid memory to sendmmsg()
      Release version 5.0

Lukas Schreckenberg (1):
      dcp_threads: Add back setting of source MAC address

Pablo Iranzo G=C3=B3mez (4):
      Use Github actions to publish documentation to gh-pages branch automa=
tically
      Apply pre-commit formatting
      Add build packages for RHEL
      Autolabel PR's based on folders used

Walfred Tedeschi (21):
      stat: Clean up and simplifications
      config: Add configuration parameters for logging via mqtt.
      logviamqtt: New feature and files added
      stats: Inserted code that to perform the periodic statistics.
      Docker: Add docker compose files and directories for MQTT - Grafana
      logviamqtt: Adding MQTT Log as optional build
      Documentation: Add MQTT chapter to the documentation
      logviamqtt: Fix the name of the variable in MQTT output
      logviamqtt: Add 1s refresh to grafana
      logviamqtt: Add a grafana dashboard example
      Improvements on password, permission and documentation.
      Limiting log generation
      logviamqtt: bug fix Ring buffer was not reading values
      config: Incoherent name of the mqttbroker ip.
      stat: Add flags for statistic from Reference and Mirror
      stat: Adding Tx time timestamp for all messages sent.
      stat: Add parsing Tx timestamp upon receiving the frame.
      stat: Add the tx timestamp to the statistics call
      stat: Add oneway statistics to the usual batch of values
      stat: adding Tx timestamp on the mirror side.
      xdp: Warning on not initialized idx

xtor (1):
      cmake: Remove install of configurations/ dir

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmbisR0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgspjD/4p8g+zwjXRe0q47Qr4w6iGcY5eiNxv
JzvMIxn0/zWziEfno7tXnsuN/eBU/m2Fug74lOVcEa0r88YhkslIluzf8QRCpNJJ
rkclA27cHNqls2wWX4p3NMc2L5LS3jmu2gsu2vP0lAue63b53tdbWqe7I0OzC2dC
4DuVb0iZq9EW5zQlxaVzBhjS9CzUTbqPr/OeXfLhfGm8f7FYl8+LRnqmDO+J/9Kp
gJcGFEHAgPM5hcTLbm0Fnw8VvpeDu2VYi8Bzs/v3BWlzE0673HRJ04G9mvDLr5eG
Qb8O4sBNnqNBY+cbU5VatCwDRBb4StsT7+YFdr7dsIPio4UfpFQO5wUIkitybpq9
a/bn3S1qrCWrI0FnPpCxKMFppFFTFDxxkbYRUwcgRfNlEzr8eYdE2tIwolnRUZdL
VKMHm0E7euugTlW+Fdv65SLiYPTG2IiMBK3HaxaltA1oyS8exNQoqwTvUqVWU64+
N8QzaofgRLGlCE4+/pIC2kIYV1mMdL3s+a6tz5go5xq2mOvQ4Y6NoymWEdFN4qYr
Cpll/r6L9ZbT/coBmfvgp2G7BZOhBJnCzXX6/gE5Hp8N4wrskeoAYXUakgJS+Kib
cwlxBfYu8/oBXHyFQPgq7RLm5O83QjC0Um8MnKYKT8vzXyARBGH0biDoVCQ6PGlc
VJ9vhEnGfHCcAg==
=etAy
-----END PGP SIGNATURE-----
--=-=-=--
