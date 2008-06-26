From: Clark Williams <williams@redhat.com>
Subject: ftrace help for NYSE
Date: Thu, 26 Jun 2008 14:31:01 -0500
Message-ID: <4863EE75.9000400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38150 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761850AbYFZTbM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jun 2008 15:31:12 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5QJVBeB023335
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Jun 2008 15:31:11 -0400
Received: from file.rdu.redhat.com (file.rdu.redhat.com [10.11.255.147])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5QJVAtw024624
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Jun 2008 15:31:10 -0400
Received: from [172.16.17.168] (dhcp-168.hsv.redhat.com [172.16.17.168])
	by file.rdu.redhat.com (8.13.1/8.13.1) with ESMTP id m5QJVA3e013870
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Jun 2008 15:31:10 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arnaldo, Luis and Steven (and everyone else :)),

Had a good conversation with NYSE this morning, including Shak, Larry Woodman and Ade
Lee, concerning tuning efforts for their CCG application (Java message routing
application). They're running the first iteration of this on the stock RHEL5.2 kernel
and have managed to tune most of the latency spikes out, but they're seeing some
serious spikes following Java GC. The GC takes 5ms (yeah, five milliseconds) and then
they see another 5ms before the app actually cranks back up. The question is whether
the GC triggers some sort of VM transactions such as page reclamation, or something
else that would basically hold off the JVM from running for 5ms.

Shak and Larry are getting them to send us SAR reports and vmstat info, but one thing
they were interested in was looking at using ftrace with a MRG trace kernel to see if
they can get a clue as to what's going on during that 10ms period.

What I'd like to do is send them a trace kernel rpm and an example script that:

	1. Mounts the debugfs (if required)
	2. turns on appropriate switches in the tracing dir
		- turn on ftrace
		- set the current tracer
		- other stuff?
	3. starts tracing
	4. runs something (cyclictest? ping?)
	5. turns off tracing
	6. dumps the trace info

- From that script, the NYSE programmers can instrument their Java app to do the same
stuff.  I'd really like it if they could just boot the trace kernel, instrument their
app, get a trace and send us the info for analysis.

Is there anything else we can do to make using ftrace easier for these guys?

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhj7nUACgkQHyuj/+TTEp04fgCgvp7mjP1XQcR3XtXq43UDnPps
6scAn2ZbU7jdwZoip3TtAh1PajFAZlax
=HJYk
-----END PGP SIGNATURE-----
