From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Linux RT newbie question
Date: Mon, 8 Feb 2016 15:03:46 +0100
Message-ID: <56B8A042.5000604@meduna.org>
References: <41302A7145AC054FA7A96CFD03835A0A0BA89C7D@EX10MBX02.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Aldrich <David.Aldrich@EMEA.NEC.COM>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:44029 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbcBHOm2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Feb 2016 09:42:28 -0500
In-Reply-To: <41302A7145AC054FA7A96CFD03835A0A0BA89C7D@EX10MBX02.EU.NEC.COM>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2/8/2016 1:16 PM, David Aldrich wrote:

> For a new project we need to demonstrate a Linux RT-Kernel
> running on a 'standard' x86 desktop PC.

What is the goal of this presentation? Are you aware that
a standard desktop PC might spoil your realtime attempts
in various ways (SMI interrupts, power management, ...)?

> I wonder if a standard Linux distro + RT kernel patch would be a better choice?

As long as you are using a RT kernel, sane pthreads support
such as modern glibc and you know what you are doing (ksoftirqd
priority and similar fun) the particular distribution does
not matter much. We are using stock Debian with custom kernel
as our embedded rt platform.

It is the _application_ that has to be coded with several things
in mind if it needs to be realtime.

-- 
                                 Stano

