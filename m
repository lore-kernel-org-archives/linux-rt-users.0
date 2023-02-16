Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F7C61DA4
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Feb 2023 17:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBPRQP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPRQO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Feb 2023 12:16:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C44DBC6
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Feb 2023 09:16:01 -0800 (PST)
Date:   Thu, 16 Feb 2023 18:15:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676567760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wy8IlN0+Vptdqz17aI6aywxEOYLqo9g6uEkOyyXgxFM=;
        b=yKp3g1AnBzl4+uCDXHJ7eGiAh2Pc+bMO6gWbIGImlPTRUbkVc+3dHrWSd4GwZnyZqk7eEs
        gpcg/5BTKntHt7Y73Irnvq2z/qUXJHRPlNiY+gR7lZh8blimionHIkwXTKCzp7RAyIFKkR
        wC8g3tbLplEGarudWCm6lTKzs4ai2SmpsyMkT/DL14e+8Y1t/rpq7pLoPym66ubW3AJulr
        Gl6BXWxeJJJWoYHgoWpnOtNuv05asRYUxzbTPiYeMlPsIQM/fpqlRwmqa06jJ8OenopUlF
        xlgDeo8ler0UFdgmEpJgTgriLARSE3TjCEs6iW1RHdehBV9bj/gUhqM4ljd9vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676567760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wy8IlN0+Vptdqz17aI6aywxEOYLqo9g6uEkOyyXgxFM=;
        b=D1TxH7tethvbLUMkbbMUgGdpJqlmoSzgfFwwmFc7MyYSpIVoptdYYr85hzTlFs7q8EnWIC
        bTTEddSTuQm2/jBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: System Hang With 5.15.79-rt54 Patch Set
Message-ID: <Y+5kz/DfgypT8Hsr@linutronix.de>
References: <fe5974c9-3ed0-938a-f43c-4d301f603e92@canonical.com>
 <be47fd9c-028a-0b6b-9c7f-877f01e73960@canonical.com>
 <dea6d0e9-7814-4b8c-44dd-4804cbe48227@canonical.com>
 <c4fe632e-568b-7c60-c6d2-99e0148680ad@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4fe632e-568b-7c60-c6d2-99e0148680ad@canonical.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-01-18 13:52:21 [-0500], Joseph Salisbury wrote:
> I'll add more details to this thread as I continue.

Any update on this?
Does the system really hang? The dmesg says:
|[ 8235.110075] INFO: task stress-ng:9466 blocked for more than 122 seconds.

which means stress-ng is blocked for quite some time due to I/O
according to the backtrace. This appears once for each stress-ng
process, 10 times in total. It does not repeat and the system runs at
least until

| [50733.471625] hid-generic 0003:03F0:7029.0004: input,hidraw1: USB HID v1.10 Mouse [iLO Virtual Keyboard] on usb-0000:01:00.4-1/input1

~11h after that report. 
Based on that it looks like the system complained about slow I/O but did
not hang as it completed its task.

Sebastian
