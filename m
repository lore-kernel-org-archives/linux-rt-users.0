From: John Sigler <linux.kernel@free.fr>
Subject: Re: PROFILE_NMI kernel config symbol
Date: Mon, 06 Aug 2007 10:52:54 +0200
Message-ID: <46B6E166.6090507@free.fr>
References: <46B1D26E.2010508@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:51845 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892AbXHFIw5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Aug 2007 04:52:57 -0400
In-Reply-To: <46B1D26E.2010508@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

John Sigler wrote:

> The -rt patch includes the following update:
> 
> Index: linux/arch/i386/oprofile/Kconfig
> ===================================================================
> --- linux.orig/arch/i386/oprofile/Kconfig
> +++ linux/arch/i386/oprofile/Kconfig
> @@ -15,3 +15,6 @@ config OPROFILE
> 
>        If unsure, say N.
> 
> +config PROFILE_NMI
> +    bool
> +    default y
> 
> 
> What is the purpose of the PROFILE_NMI config symbol?
> (It does not seem to be used anywhere else in the -rt patch.)

Should I provide a patch removing this configuration option?
