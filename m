From: David Aldrich <David.Aldrich@EMEA.NEC.COM>
Subject: RE: Linux RT newbie question
Date: Mon, 8 Feb 2016 14:28:26 +0000
Message-ID: <41302A7145AC054FA7A96CFD03835A0A0BA8AD12@EX10MBX02.EU.NEC.COM>
References: <41302A7145AC054FA7A96CFD03835A0A0BA89C7D@EX10MBX02.EU.NEC.COM>
 <56B8A042.5000604@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cluster-a.mailcontrol.com ([85.115.52.190]:49358 "EHLO
	cluster-a.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbcBHO2g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Feb 2016 09:28:36 -0500
In-Reply-To: <56B8A042.5000604@meduna.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Stano

Thanks for your reply ...

> > For a new project we need to demonstrate a Linux RT-Kernel running
> > a 'standard' x86 desktop PC.
> 
> What is the goal of this presentation? 

The goal is to demonstrate that a communication system previously implemented on embedded digital signal processors can be implemented on a high spec PC desktop. Sorry that I can't give more details.

> Are you aware that a standard desktop
> PC might spoil your realtime attempts in various ways (SMI interrupts, power
> management, ...)?

Well, I was not aware of this until reading your email and I read ' HOWTO: Build an RT-application' on rt.wiki.kernel.org. The HowTo suggests ways of reducing the impact of SMI interrupts. Is this possible?

> > I wonder if a standard Linux distro + RT kernel patch would be a better
> choice?
> 
> As long as you are using a RT kernel, sane pthreads support such as modern
> glibc and you know what you are doing (ksoftirqd priority and similar fun)
> the particular distribution does not matter much. We are using stock Debian
> with custom kernel as our embedded rt platform.

Do you build your kernel yourselves?

Best regards

David
