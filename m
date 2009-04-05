From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Announce] 2.6.29.1-rt4
Date: Sun, 5 Apr 2009 10:53:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904051052560.747@localhost.localdomain>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>  <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>  <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>  <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain>
 <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain>  <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain>  <alpine.LFD.2.00.0903231723090.29264@localhost.localdomain>  <alpine.LFD.2.00.0903252154040.3397@localhost.localdomain>
 <alpine.LFD.2.00.0904020155320.12916@localhost.localdomain>  <alpine.LFD.2.00.0904031918090.12916@localhost.localdomain> <49b7c2350904042028q8865f80tcf56500e8a009c0d@mail.gmail.com> <alpine.LFD.2.00.0904051038350.747@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:35248 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbZDEIyJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 04:54:09 -0400
In-Reply-To: <alpine.LFD.2.00.0904051038350.747@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 5 Apr 2009, Thomas Gleixner wrote:

> GeunSik,
> 
> On Sun, 5 Apr 2009, GeunSik Lim wrote:
> > I have one question. What is "broken-out" 's meaning  for rt patch file?
> 
> The broken out tar ball contains a patch series of smaller patches,
> which need to be applied in a give order. The order is determined from
> the series file. It's a "quilt" series. quilt is a patch series
> management tool. "man script" 

Of course I meant: man quilt

   tglx
