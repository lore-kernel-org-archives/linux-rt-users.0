Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95324C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Feb 2022 07:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiBBH4m (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:56:42 -0500
Received: from mail.nearlyone.de ([46.163.114.145]:53664 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiBBH4m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Feb 2022 02:56:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 095395CFFC;
        Wed,  2 Feb 2022 08:56:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1643788600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=+/PTLL5Z1esg0cXIS5zfWQfFQQTOtLX9CBrIYbWwqxU=;
        b=Q9OEoNRzu+ai7c8ZNGGsvNUI2iPgP0qatQu3ragFx4amerxa7JrYnuR8gz2rMg2a00V4VQ
        MTQEQjRhjVBGqwW1EvOWCK//2u6u3zn8qKxlDghS1rgEwU/iFOnPbYpkHAtdzWRGVn0tx/
        9OYyJf9sgq+faj+NRRgXRQ41yMgYtHjNZkmWCE5BLtjhF4tbJAK1LAB+McvhkYpJvBmoe9
        3yieUtQSG6GsKh9Xr3SCzyofaZmaXQYWBbZXecdN2GKksYvh/p+1WcgoEEBuHIrJH1hqJQ
        N+3BEd14qt8CL12cP2Zt7zjwT7dH4erOPaSl7Ub0PoT1e2GVwXfyEq/TURFmHg==
Message-ID: <da5b0bc4-0980-5193-cb65-c1b06e46574b@monom.org>
Date:   Wed, 2 Feb 2022 08:56:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [ANNOUNCE] 4.4.301-rt231
Content-Language: en-US
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <164373149744.25521.668105457088547829@beryllium.lan>
In-Reply-To: <164373149744.25521.668105457088547829@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 01.02.22 17:14, Daniel Wagner wrote:
> Hello RT-list!
> 
> I'm pleased to announce the 4.4.301-rt231 stable release.
> 
> This is just an update to the latest and last 4.4.x stable
> release. There are no RT specific changes.
> 
> With this release there wont be any updates for this branch in
> stable-rt tree. I understand Pavel Machek is continuing to maintaining
> the v4.4-rt branch under the CIP umbrella:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt
> 

It seems Greg is still updating v4.4.y. I'll do another update, when 
4.4.y gets an update

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-4.4.y
