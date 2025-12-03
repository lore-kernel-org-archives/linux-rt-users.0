Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3372628
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Dec 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764749746; cv=none; b=S9kWXRc4pifoWRxHognw7GiDF5B3mC/MUIbeIjyoGsk1ccEdCwEusQvmDXvFjx3utj116Ts/16vJzVwiwRyseFznap8JFO6JXI7k3O+Rve6N9tlswKiElxcmXsMCEmIUX+HYADZMrpA6ipjJnmku8WzFotdwX2VX86M1IN/oJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764749746; c=relaxed/simple;
	bh=DboyPWZUFlZxVrU7HByqPRCbQ3UPt2p5RsejFebQFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FJgQ9hijmpVCzup/8a11w1HA1mN5qzbPkTG7A2AaAAlO6j3OIVa3aLiSUag1f/XAhia2CRr+SiZZUTXepKk3c/dhbLGxhGd060uSyzSzAjGTUuc88pupSr0j8OpWWH5hawDbxTpwLe8X91ln7zPVwvH5uJNjQ44RX4APulBLdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJXumdWw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vy8MVt2x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJXumdWw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vy8MVt2x"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764749742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tdOicAgWBUX58hSYpvyGuImhoKcMkTd1yNNxxkOsNw8=;
	b=GJXumdWw3kyhtm7mzi1QD67GBmrE6Z9S+YPGTo6wHMZ0ovkfHw6o4JJG0vCJF9FKAvTkdb
	4TnMtdNu01lgywypSa9BeFm0z5HD4u+gjmGrG2brVx2/UZHJsNIXdggdlP5Voos1tOcg8B
	P/vu5ppMbpFUru7KoAYso5RDvUn3dlaLysgKzMWdrbvBgeQ6VBGx6wPVZn/cr4kSU1XmrH
	siqETOAamFK65fmvbIbOBYNXKa95zLS4al/NK5nyk5AHKSb/Aansz+4r85fNoG35em9oYu
	FFwxVErARbRw3B751ami02tZUWVRMZLxX5tQlP48mYR2Im4Eh+Rw2SDwUKr3vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764749742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tdOicAgWBUX58hSYpvyGuImhoKcMkTd1yNNxxkOsNw8=;
	b=vy8MVt2xa05grup0e+D+o2aTSdQbg/ylR36R9waIrukO+jfRs6FmjwCZasGycAuDN2j6Go
	5ZiCDdlMJLac9WBA==
To: rt-users <linux-rt-users@vger.kernel.org>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, "Choong, Chwee Lin"
 <chwee.lin.choong@intel.com>, "Oehrlein, Scott"
 <scott.oehrlein@intel.com>, "Zage, David" <david.zage@intel.com>, "Blanco
 Alcaine, Hector" <hector.blanco.alcaine@intel.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan
 Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] RTC/TSN-Testbench v5.4
Date: Wed, 03 Dec 2025 09:15:39 +0100
Message-ID: <87345srnf8.fsf@jax.kurt.home>
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

I'm pleased to announce version v5.4 of Linux RTC/TSN-Testbench.

Release notes:

- Add statistics based on XDP HW timestamping contributed by Faizal Abdul
  Rahim and Chwee-Lin Choong
  See https://linutronix.github.io/RTC-Testbench/processing_latency.html
- Add interface to execute real time compute workload each network cycle
  contributed by Scott Oehrlein
  See https://github.com/Linutronix/RTC-Testbench/tree/main/tests/workloads
- Add logging statistics via JSON over UDP
- Add tests for SRIOV, container networking and Frame Preemption

Thanks to all contributors.

You can get the code and documentation via the git tree at:

  https://github.com/Linutronix/RTC-Testbench

Thanks,
Kurt

Shortlog v5.3..v5.4:

Chwee-Lin Choong (4):
      xdp: add TX hardware timestamping support in AF_XDP for latency measurement
      tests: Add TxTimeStampEnabled fields to YAML configs
      stat: Add processing latency metrics for mirror mode
      doc: Add Processing Latency documentation

Faizal Abdul Rahim (3):
      xdp: Enable RX hardware timestamp in XDP program
      stat: Measure and log RX latency
      xdp: Fix missing Rx latency when launch time is enabled

Kurt Kanzenbach (35):
      doc: Add security documentation
      tests: Add library
      tests: Convert all flow scripts to new lib
      config: Add BaseTime offset
      tests: Add Profinet SRIOV scenario
      README: Remove ToDo about container networking
      tests: Add testcase for i225/i226 FPE
      README: Remove ToDo about FPE
      tools: build: Add new compile options
      scripts: ptp: Add stop of chrony
      xdp: Move comment
      ci: Limit build options on Ubuntu
      main: Print statistics
      elbe: Update to Debian Trixie
      cmake: Limit RT workloads to x86_64 builds for now
      README: Remove ToDo for real time compute workloads
      doc: Add a workload section
      all: Run pre-commit
      config: Remove superfluous "\n"
      mqtt: Rename mqtt logging to log_mqtt
      mqtt: Remove obsolete stuff
      mqtt: Rename user visible mqtt options
      json: Add config parameters for logging via JSON
      net: Add function for creating an UDP client socket
      json: Add JSON/UDP logger
      stat: Add helper function to build json from stats
      ref/mirror: Wire up JSON logger
      scripts: Add script for printing statistics
      doc: Fix name of config option
      doc: Document new json config options
      doc: Add missing default value
      doc: Document all available statistics
      elbe: Add zstd to package list
      json: Add proper error handling
      Release version v5.4

Scott Oehrlein (5):
      TsnHigh: Execute a dynamically loaded workload each network cycle
      Sample workload that is dynamically loadable by RTC-Testbench.
      Busypolling example that invokes the pointer_chasing workload.
      tsn: Update comment
      tests/workloads: Update README's

dependabot[bot] (6):
      build(deps): bump awalsh128/cache-apt-pkgs-action from 1.5.0 to 1.5.1
      build(deps): bump awalsh128/cache-apt-pkgs-action from 1.5.1 to 1.5.3
      build(deps): bump actions/checkout from 4 to 5
      build(deps): bump actions/setup-python from 5 to 6
      build(deps): bump awalsh128/cache-apt-pkgs-action from 1.5.3 to 1.6.0
      build(deps): bump actions/checkout from 5 to 6

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmkv8asTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgqiCD/9ZGQUJSCIGAiCniS54DFWC7H+dVzK1
R5200XKj34FTBLYYynKeNoxLXwFHBd3S7aUOXGzZd5BTbkc/x+vX/0CdcPKQssY4
nmSvy3k2tqHQn0wx3YvE3wFCJ/KnuRIZB7dmZdHt0daJc1zoBLrEBFBU7vn87X6/
v0tdXKA3FNt3crEQyiWSleogEx6d4x8e3haugeT0PFf/i33120NZjFRCEd9dSX/T
4IpBf6IfRBPB78Ina3eks46JMx+FaK9kyZI3aBCzoJ6QYSQmdeh7KmpjeutmhCuX
xfgd+4Xro0vrblukMhyVQzrDAfakShM00GrguVnil4jOXZdzISb8Ve48lF8X45x0
rZLKOaJwKyFvi/2bQ20pr3yY1J+isBInIDz9JDTUZxqqp/5a2nEwdMLdiMeW7ebx
z6fjz49irXcmM31G0Kwx55hHBqdg9NalCpMB6H+haLocGfvr9eGRsIUa8crwvoFE
sgjH92vDhAD6eusOaaZ/1ZMmPmSmSLtaIG52xJRixAr4mApMd+C3DtqKpTCdzeSX
CyzPlbGUXrDrTsoCFbuQGzhGsMmxLDvekBJ6yvZX679OumNbAtRcIfFs0kyZ4NPF
EvFuXwbuENYUT/x6H/GzGGGJnUJb5IHhNdt4L9IRfX64wSGMNJZY5ZU8XnK70XWl
kEaHJEHHdq4akw==
=0klP
-----END PGP SIGNATURE-----
--=-=-=--
