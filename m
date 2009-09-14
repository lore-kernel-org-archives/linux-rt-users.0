From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: RT tests on OMAP3
Date: Mon, 14 Sep 2009 10:50:07 -0700
Message-ID: <8763bl4drk.fsf@deeprootsystems.com>
References: <f96d234e0908311350u5d3d7680gfbf46a1c8f9de58f@mail.gmail.com>
	<f96d234e0908312016v4ffb9765pe06dc53e5e679758@mail.gmail.com>
	<f96d234e0908312018j5f36d6e1s95319f4669105d06@mail.gmail.com>
	<87tyzkw1an.fsf@deeprootsystems.com>
	<f96d234e0909031357i45c3b689sdd034e46b786b7c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Linux OMAP Users <linux-omap@vger.kernel.org>
To: Cliff Brake <cliff.brake@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:65467 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbZINRuH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 13:50:07 -0400
In-Reply-To: <f96d234e0909031357i45c3b689sdd034e46b786b7c4@mail.gmail.com> (Cliff Brake's message of "Thu\, 3 Sep 2009 16\:57\:03 -0400")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Cliff Brake <cliff.brake@gmail.com> writes:

> On Thu, Sep 3, 2009 at 10:28 AM, Kevin
> Hilman<khilman@deeprootsystems.com> wrote:
>
>> I've been using -rt on a basic OMAP3 kernel, but have not enabled
>> EHCI so haven't seen this.
>
> What kernel version are you running, and what are you using for your
> timer config?
>
> # CONFIG_OMAP_MBOX_FWK is not set
> # CONFIG_OMAP_MPU_TIMER is not set
> CONFIG_OMAP_32K_TIMER=y
> CONFIG_OMAP_32K_TIMER_HZ=128
> CONFIG_OMAP_DM_TIMER=y

I'm using the 32K timer as you are for PM reasons.  The 32k timer is
in the wakeup powerdomain so is not disabled during low power
idle/suspend.

Kevin
