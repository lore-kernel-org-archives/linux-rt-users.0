From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: List archive broken?
Date: Wed, 20 Dec 2006 00:30:39 +0100
Message-ID: <m364c7sbts.fsf@quimbies.gnus.org>
References: <45883424.8070909@gmail.com> <20061219202137.GA11035@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dirk Behme <dirk.behme@googlemail.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from quimbies.gnus.org ([80.91.231.2]:40353 "EHLO quimbies.gnus.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbWLSXyw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Dec 2006 18:54:52 -0500
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20061219202137.GA11035@thunk.org> (Theodore Tso's message of
	"Tue\, 19 Dec 2006 15\:21\:37 -0500")
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> It looks like some spammers got a hold of the input address for the
> gmane.org site for the linux-rt-users mailing list and directed spam
> directly into gmane.org.

The reason for the odd behaviour of
http://news.gmane.org/gmane.linux.rt.user is a unfortunately that the
server that runs daemon that generates the web interface ran into some
rather large problems last week.  It's an x86_64 machine, and it
started complaining about running out of IOMMU space, and therefore
couldn't write to disk once in a while.

Dec 10 11:50:54 deer kernel: PCI-DMA: Out of IOMMU space for 520192 bytes at device 0000:00:07.0
Dec 10 11:50:54 deer last message repeated 4 times
Dec 10 11:50:54 deer kernel: sd 1:0:0:0: SCSI error: return code = 0x70000
Dec 10 11:50:54 deer kernel: end_request: I/O error, dev sdb, sector 37085367
Dec 10 11:50:54 deer kernel: printk: 4 messages suppressed.
Dec 10 11:50:54 deer kernel: Buffer I/O error on device sdb1, logical block 4635663
Dec 10 11:50:54 deer kernel: lost page write due to I/O error on sdb1

I didn't notice for a while, and when I did, the thread index the web
interface uses was b0rken.

Normally I would just have started a thread rebuild, but it takes
about five days for that to complete, and I'm going away on holiday in
three days, so it didn't seem like a good idea.

Perhaps I could just switch it over to the backup daemon.  That,
unfortunately is under powered now that traffic has grown so much, but
it might be worth a try.

Yup, looks ok there now:

  http://news.gmane.org/gmane.linux.rt.user

-- 
(domestic pets only, the antidote for overdose, milk.)
  larsi@gnus.org * Lars Magne Ingebrigtsen
