From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Subject: Re: RT Patch set, SystemTap, tcp test fails
Date: Sun, 19 Nov 2006 22:33:41 -0500
Message-ID: <20061120033341.GA20408@ti64.telemetry-investments.com>
References: <1163934741.6306.20.camel@fc6-rt> <y0mvelb1ciu.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dave_sperry@ieee.org, systemtap@sources.redhat.com,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gw1a.telemetry-investments.com ([64.20.161.180]:32396 "EHLO
	sv1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S933907AbWKTDdp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Nov 2006 22:33:45 -0500
To: "Frank Ch. Eigler" <fche@redhat.com>
Content-Disposition: inline
In-Reply-To: <y0mvelb1ciu.fsf@ton.toronto.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Nov 19, 2006 at 02:07:05PM -0500, Frank Ch. Eigler wrote:
> According to mingo's patch set, HRTIMER_REL and HRTIMER_ABS were
> simply renamed to HRTIMER_MODE_REL and HRTIMER_MODE_ABS.  Since these
> are enums instead of macros, a little #ifndef/#define hack would not
> work.  Unless the RT patches identify themselves at compile time, it
> may be tricky to generate code that works with both base and patched
> kernel.

The real-time patch replaces the enumeration constants:

 enum hrtimer_mode {
-       HRTIMER_ABS,    /* Time value is absolute */
-       HRTIMER_REL,    /* Time value is relative to now */
+       HRTIMER_MODE_ABS,       /* Time value is absolute */
+       HRTIMER_MODE_REL,       /* Time value is relative to now */
 };

It is possible to achieve backwards compatibility in enumerations by
simply declaring the deprecated names to have the values assigned to
the new names:

enum hrtimer_mode {
	HRTIMER_MODE_ABS,	/* Time value is absolute */
	HRTIMER_ABS = HRTIMER_MODE_ABS,	/* backwards compatibility */
	HRTIMER_MODE_REL,	/* Time value is relative to now */
	HRTIMER_REL = HRTIMER_MODE_REL,	/* backwards compatibility */
};

Regards,

	Bill Rugolsky
