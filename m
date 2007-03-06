From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: [irda-users] 2.6.18-rt6 IrDA strangeness
Date: Tue, 6 Mar 2007 15:37:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703061533400.534@pcgl.dsa-ac.de>
References: <FvWAtRUd.1173190966.6915950.samuel@sortiz.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org, irda-users@lists.sourceforge.net,
	Thomas Gleixner <tglx@linutronix.de>
To: Samuel Ortiz <samuel@sortiz.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:54163 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965103AbXCFOhJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2007 09:37:09 -0500
In-Reply-To: <FvWAtRUd.1173190966.6915950.samuel@sortiz.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

(I think, we can remove Thomas and linux-rt-users from CC: now that it's 
clearly not a -rt bug, unless they express their interest in this 
thread:-))

On Tue, 6 Mar 2007, Samuel Ortiz wrote:

> On 3/6/2007, "Guennadi Liakhovetski" <gl@dsa-ac.de> wrote:
>
>> On Tue, 6 Mar 2007, Guennadi Liakhovetski wrote:
>>
>> Ok, I also managed to reproduce this with non-rt kernel, so, it's just
>> some incompatibility between 2.4 and 2.6... Might be considered as a nug
>> on the 2.4 "reference" side.
>
> If you don't see the problem with two 2.6 peers, then it's definitely a
> 2.4 bug...Have you tried that ?

No, not yet. As soon as I get a chance, will verify that.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
