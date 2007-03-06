From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: [irda-users] 2.6.18-rt6 IrDA strangeness
Date: Tue, 6 Mar 2007 15:05:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703061503540.534@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0703021500020.1799@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0703021741160.534@pcgl.dsa-ac.de> <Pine.LNX.4.63.0703060938090.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org, irda-users@lists.sourceforge.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:53810 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031AbXCFOGB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2007 09:06:01 -0500
In-Reply-To: <Pine.LNX.4.63.0703060938090.534@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 6 Mar 2007, Guennadi Liakhovetski wrote:

> Ok, just tried 20-rt8. Of 3 problems described earlier the first two:
> non-working syslog(2) and irdadump showing packets only in one direction
> are now gone. Whereas the third one:

[...]

> is still there.

Ok, I also managed to reproduce this with non-rt kernel, so, it's just 
some incompatibility between 2.4 and 2.6... Might be considered as a nug 
on the 2.4 "reference" side.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
