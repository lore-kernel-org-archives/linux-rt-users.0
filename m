From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: locking changes in tty broke low latency feature
Date: Wed, 19 Feb 2014 23:35:11 +0000
Message-ID: <20140219233511.2467cdc8@alan.etchedpixels.co.uk>
References: <20140219130308.GC1851@redhat.com>
	<20140219230623.736E8406062@ip-64-139-1-69.sjc.megapath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Hurley <peter@hurleysoftware.com>,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Hal Murray <murray+fedora@ip-64-139-1-69.sjc.megapath.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140219230623.736E8406062@ip-64-139-1-69.sjc.megapath.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> gpsd uses TIOCMIWAIT to get a wakeup from a PPS signal connected to a modem 
> control line.  That path might have the same problem and/or some ideas on how 
> to handle the data case.

TIOCMIWAIT should be fine. The data processing is deferred but very few
devices defer processing of modem change events.

Alan
