From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [(RT RFC) PATCH v2 4/9] optimize rt lock wakeup
Date: Mon, 3 Mar 2008 10:37:29 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0803031036380.18766@gandalf.stny.rr.com>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net>
 <20080225160058.11268.96036.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, pavel@ucw.cz, acme@redhat.com,
	gregkh@suse.de, sdietrich@novell.com, pmorreale@novell.com,
	mkohari@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:42879 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588AbYCCPhc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Mar 2008 10:37:32 -0500
In-Reply-To: <20080225160058.11268.96036.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 25 Feb 2008, Gregory Haskins wrote:

> It is redundant to wake the grantee task if it is already running

This is only expensive for your adaptive mutex algorithm, not what is in
there today. It belongs _after_ the adaptive mutex patch in the series.

-- Steve
