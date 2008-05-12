From: Alex Tsariounov <alext@novell.com>
Subject: Cpuset management utility 0.9.1 release announcement
Date: Mon, 12 May 2008 13:01:39 -0600
Message-ID: <1210618899.7113.10.camel@zuul>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:59021 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527AbYELTBo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 May 2008 15:01:44 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are please to announce the release of cpuset v0.9.1 available here:

 Source:   http://developer.novell.com/wiki/index.php/Cpuset
 Packages: http://download.opensuse.org/repositories/home:/tsariounov:/cpuset/

Cpuset is a GPL v2 Python application to make using the cpusets
facilities in the Linux kernel easier. It allows manipulation of cpusets
on the system and provides higher level functions such as implementation
and control of a basic CPU shielding setup.  The actual command is
called cset.

If you're tired of manipulating cpusets by hand, or writing and
rewriting cpuset startup scripts to help manage shielding, then this
tool could be for you.

The source link above contains access to a subversion repository,
bugzilla instance and mailing lists for cpuset.

For an more in-depth writeup on cpuset, see the RT wiki at:
http://rt.wiki.kernel.org/index.php/Cpuset_management_utility

Thanks,
Alex Tsariounov

