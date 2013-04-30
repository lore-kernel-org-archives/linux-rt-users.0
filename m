From: David VomLehn <David.VomLehn@spacex.com>
Subject: EDAC messages about corrected errors affect realtime response
Date: Mon, 29 Apr 2013 18:07:58 -0700
Message-ID: <20130430010733.GA1404@dvomlehn-z8.spacex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: <linux-edac@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mta2.spacex.net ([64.47.164.142]:61763 "EHLO mta2.spacex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758858Ab3D3Bge (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Apr 2013 21:36:34 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The EDAC code currently prints numerous lines on the console when corrected
errors occur.  This can be a problem for realtime systems, as calling printk()
will eat a chunk of time that may be critical to processing of the realtime
workload, even though the system can proceed normally.

I'm working on a solution that allows a user space logger program to collect
corrected error information without disrupting the system. This relies on
reporting such errors via sysfs instead of the console.

1.	The directories in which the files would reside use the existing
	sysfs hierarchy. For example, L2 cache files would be in:

		/sys/device/system/edac/cpu/L2

2.	Device-dependent error data files would be added in an appropriate
	sysfs directory.  So, L2 cache-specific error data files might be:

	o	data capture (32-bit or 64-bit data items)
	o	address capture (as many bits as the physical address)
	o	syndrome (format is device dependent)
	o	attributes (format is device dependent)

	The idea is that reading each file once will retrieve the tuple of
	error data items for a single correctable error.

3.	Each file added is backed by a small queue so that information for
	multiple errors can be retrieved. Reading a datum discards that
	item.

4.	A sequence number file is added that should be read at the
	same time as the error data files. The sequence number is incremented
	for each error, even if the error data had to be discarded to avoid
	queue overflow. This allows detection of queue overflow by the
	logger program.

5.	If a logger dies partway through reading the error data files, the
	data will no longer be synchronized. To address this, writing to
	the sequence number file will cause any out-of-synch error data items
	to be discarded. This will allow the next read of all files to obtain
	the next complete tuple of error data.

I would expect to keep the current console output as the default, but to be
able to select console output, sysfs output, or both.

Things I'd like feedback on:
1.	Is sysfs even a reasonable place for this?
2.	Is this a workable interface for this information? Note that, unlike
	the console, this is a lossy reporting mechanism.
3.	Other suggestions?

Note: There may be other subsystems that also use printk() to report on
corrected errors. These are also likely to pose an issue for realtime systems
and this may become a model for handle non-EDAC situations.
-- 
David VL
