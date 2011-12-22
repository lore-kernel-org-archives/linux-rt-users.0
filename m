From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.0.14-rt31
Date: Thu, 22 Dec 2011 06:50:20 -0500
Message-ID: <1324554620.8892.1.camel@acer.local.home>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com>
	 <CAPB=Z-rrMLyFAJXUBC+BCqegr2bNB4on0gNaTWY-ddMWsMGJpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:62047 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1LVLuV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Dec 2011 06:50:21 -0500
In-Reply-To: <CAPB=Z-rrMLyFAJXUBC+BCqegr2bNB4on0gNaTWY-ddMWsMGJpA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-12-22 at 13:08 +0200, Raz wrote:
> Hey steven
> 
> what is the relation between 3.2 rt patches and 3.0 rt patches ? back
> portability or anything else ?

3.0-rt is the stable release. 3.2-rt is active development. Only fixes
go into 3.0-rt.

-- Steve


