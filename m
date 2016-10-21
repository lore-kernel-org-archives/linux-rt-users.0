From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] i915 monitor hotplug on 4.1/4.4 PREEMPT
Date: Fri, 21 Oct 2016 14:27:56 +0200
Message-ID: <20161021122756.GY20761@phenom.ffwll.local>
References: <CAKP5S=2GhofOeDr7tv32s+WPue+QhtFYUGjdQ7Mxfh91Neh+7A@mail.gmail.com>
 <87r37bqk6d.fsf@intel.com>
 <20161020125708.GB8202@suiko.acc.umu.se>
 <CAKP5S=1Rb-Ees3TgeviXFdPfJqt3E0YwfRQKuyeumXAjM4bGOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Weinehall <tao@kernel.org>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34274 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755228AbcJUM2A (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Oct 2016 08:28:00 -0400
Received: by mail-lf0-f65.google.com with SMTP id x23so5418683lfi.1
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Oct 2016 05:28:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKP5S=1Rb-Ees3TgeviXFdPfJqt3E0YwfRQKuyeumXAjM4bGOw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Oct 20, 2016 at 05:09:52PM +0300, Nicolae Rosia wrote:
> Hi,
> 
> On Thu, Oct 20, 2016 at 3:57 PM, David Weinehall <tao@kernel.org> wrote:
> >> > I get an udev event for unplugging, but there's no event generated for
> >> > plugging the monitor back in.
> >>
> >> Does it work on non-RT? Does it work on v4.8 or v4.9-rc1?
> >
> > The second one is relevant though. 4.1 is pre-historic, 4.4 is ancient.
> I just tested this on v4.8.2-rt2 and it works.
> 
> Any tips on what I should do next, excluding the upgrade :-) ?

Very, very likely the answer is "upgrade", because:

$ git log --oneline v4.4..v4.8 -- drivers/gpu/drm/i915/ | wc -l
1931

That's not even counting the drm core changes, which also might be
relevant. Normally a revert bisect (to figure out the bugfix, hoping that
it's just 1 patch and not an entire series) would be an option. But since
-rt is still an add-on you'd need to rebase the entire -rt patchset every
time. That's impossible.

If you have way too much time, and know what you're doing another option
might be to backport all of drm (to avoid conflicts between drm core and
i915) from 4.8 to 4.4. No guarantee at all it'll work, and we generally
keep a few people busy for a while every time we have to do that
internally for some product team.

So yeah, "upgrade" is very likely is.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
