From: Trevor Woerner <twoerner@gmail.com>
Subject: Re: RT_PREEMPT on Raspberry PI 3
Date: Wed, 30 Nov 2016 21:25:51 -0500
Message-ID: <20161201022551.GB32547@openSUSE-i7.site>
References: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Giuliano Colla <giuliano.colla@fastwebnet.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:32837 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbcLACZz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 30 Nov 2016 21:25:55 -0500
Received: by mail-io0-f169.google.com with SMTP id j65so389994705iof.0
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Nov 2016 18:25:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun 2016-09-18 @ 12:03:42 PM, Giuliano Colla wrote:
> 1) The RT patches are not in sync with mainline Raspbian kernel versions.

The PREEMPT_RT patches aren't only meant for RaspberryPi devices. But even if
they were, there are dozens (!) of GNU/Linux-based distributions which target
RaspberryPi devices[1]. I'm glad the -rt developers don't show bias in the
distros to which they align their patches :-)




[1] http://elinux.org/RPi_Distributions (NOTE: not all of the listed distros
are GNU/Linux, but many of them are)
