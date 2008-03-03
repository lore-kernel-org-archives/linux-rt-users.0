From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [(RT RFC) PATCH v2 4/9] optimize rt lock wakeup
Date: Mon, 03 Mar 2008 08:41:56 -0700
Message-ID: <47CBD5F4.BA47.005A.0@novell.com>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net>
 <20080225160058.11268.96036.stgit@novell1.haskins.net>
 <Pine.LNX.4.58.0803031036380.18766@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <a.p.zijlstra@chello.nl>, <mingo@elte.hu>, <bill.huey@gmail.com>,
	<kevin@hilman.org>, <tglx@linutronix.de>, <cminyard@mvista.com>,
	<dsingleton@mvista.com>, <dwalker@mvista.com>,
	"Moiz Kohari" <MKohari@novell.com>,
	"Peter Morreale" <PMorreale@novell.com>,
	"Sven Dietrich" <SDietrich@novell.com>, <dsaxena@plexity.net>,
	<acme@redhat.com>, <ak@suse.de>, <gregkh@suse.de>,
	<npiggin@suse.de>, <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:31233 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023AbYCCPsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Mar 2008 10:48:45 -0500
In-Reply-To: <Pine.LNX.4.58.0803031036380.18766@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Mon, Mar 3, 2008 at 10:37 AM, in message
<Pine.LNX.4.58.0803031036380.18766@gandalf.stny.rr.com>, Steven Rostedt
<rostedt@goodmis.org> wrote: 

> On Mon, 25 Feb 2008, Gregory Haskins wrote:
> 
>> It is redundant to wake the grantee task if it is already running
> 
> This is only expensive for your adaptive mutex algorithm, not what is in
> there today. It belongs _after_ the adaptive mutex patch in the series.
> 
> -- Steve

Fair enough.

-Greg

