From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] i915 monitor hotplug on 4.1/4.4 PREEMPT
Date: Fri, 21 Oct 2016 20:14:08 +0200
Message-ID: <20161021181408.GM20761@phenom.ffwll.local>
References: <CAKP5S=2GhofOeDr7tv32s+WPue+QhtFYUGjdQ7Mxfh91Neh+7A@mail.gmail.com>
 <87r37bqk6d.fsf@intel.com>
 <20161020125708.GB8202@suiko.acc.umu.se>
 <CAKP5S=1Rb-Ees3TgeviXFdPfJqt3E0YwfRQKuyeumXAjM4bGOw@mail.gmail.com>
 <20161021122756.GY20761@phenom.ffwll.local>
 <CAKP5S=3Fwws3tMFcijT+PfBFQnCqNLhXL89_SVPv4iWmu0YDYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Vetter <daniel@ffwll.ch>, David Weinehall <tao@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36066 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932749AbcJUSOM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Oct 2016 14:14:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so653628wmg.3
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Oct 2016 11:14:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKP5S=3Fwws3tMFcijT+PfBFQnCqNLhXL89_SVPv4iWmu0YDYA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 21, 2016 at 04:21:53PM +0300, Nicolae Rosia wrote:
> Hello,
> 
> On Fri, Oct 21, 2016 at 3:27 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> > So yeah, "upgrade" is very likely is.
> I see...
> 
> i915.disable_power_well=0 seems to do the trick.
> Is it safe to use? The kernel gets tainted because of this.

We taint the kernel on principle if you touch any of these debug options,
i.e. don't send us bug reports if it blows up. Because it'll be running
untested codepaths.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
