From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: appearance of /proc/interrupts ?
Date: Thu, 11 Jan 2007 12:04:17 +0100
Message-ID: <45A619B1.7020302@imc-berlin.de>
References: <45A608A0.1050407@imc-berlin.de> <20070111095055.GA29844@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4669 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030281AbXAKLEU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 06:04:20 -0500
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20070111095055.GA29844@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo,

>> What does it mean? Is RT PREEMPT not working correctly?
> 
> i restored it to be as compatible with upstream as possible. You have a 
> PREEMPT_RT kernel if you have this message in the dmesg:
> 
>   Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
> 

Ah. I see. Thanks! Maybe someone could update the wiki then! ;-)

Thanks a million,

Steven
