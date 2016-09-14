From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: Network Issue
Date: Wed, 14 Sep 2016 13:26:14 +0200
Message-ID: <20160914112614.afmbzxbgufz455u5@pengutronix.de>
References: <CAGiFfw4o2c1f=pR+gKkVYAoHQ7V8ywLXu-_g9ahWSZoAoSD7tA@mail.gmail.com>
 <20160908061920.msefkdj4nk3exzpr@pengutronix.de>
 <CAGiFfw64YmXt7-dRG-_UM+nZ9R8VznqThiWhDxMVJtXvnKBwSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: "Hardik A Gohil (WMSC-HW)" <hardik@willowglen.asia>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58235 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761649AbcINL0R (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Sep 2016 07:26:17 -0400
Content-Disposition: inline
In-Reply-To: <CAGiFfw64YmXt7-dRG-_UM+nZ9R8VznqThiWhDxMVJtXvnKBwSQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 14, 2016 at 03:51:28PM +0800, Hardik A Gohil (WMSC-HW) wrote:
> On Thu, Sep 8, 2016 at 2:19 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello,
> >
> > On Thu, Sep 08, 2016 at 09:49:14AM +0800, Hardik A Gohil (WMSC-HW) wrote:
> >> I am working on Linux 3.2.0.
> >
> > Wow, you're still developing on a kernel that is 4.5 years old and
> > you're not even taking the stable updates.
> 
> since we did development with phyCORE-AM335x-PD13.1.2 which is using 3.2 kernel.
> we have already completed production and it wont be a easy task to
> shift to 4. series

Consider it a development step to update to a newer kernel. This allows
you to test if the problem exists there, too, fix it and then being able
to backport it. Note all this doesn't force you to upgrade your machines
in the field.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
