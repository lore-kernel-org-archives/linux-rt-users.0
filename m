From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: Re: [Intel-gfx] i915 monitor hotplug on 4.1/4.4 PREEMPT
Date: Fri, 21 Oct 2016 16:21:53 +0300
Message-ID: <CAKP5S=3Fwws3tMFcijT+PfBFQnCqNLhXL89_SVPv4iWmu0YDYA@mail.gmail.com>
References: <CAKP5S=2GhofOeDr7tv32s+WPue+QhtFYUGjdQ7Mxfh91Neh+7A@mail.gmail.com>
 <87r37bqk6d.fsf@intel.com> <20161020125708.GB8202@suiko.acc.umu.se>
 <CAKP5S=1Rb-Ees3TgeviXFdPfJqt3E0YwfRQKuyeumXAjM4bGOw@mail.gmail.com> <20161021122756.GY20761@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Weinehall <tao@kernel.org>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34848 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933352AbcJUNVz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Oct 2016 09:21:55 -0400
Received: by mail-it0-f67.google.com with SMTP id 139so11061143itm.2
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Oct 2016 06:21:55 -0700 (PDT)
In-Reply-To: <20161021122756.GY20761@phenom.ffwll.local>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Fri, Oct 21, 2016 at 3:27 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> So yeah, "upgrade" is very likely is.
I see...

i915.disable_power_well=0 seems to do the trick.
Is it safe to use? The kernel gets tainted because of this.

Regards,
Nicolae
