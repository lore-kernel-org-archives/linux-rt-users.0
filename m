From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded context
Date: Fri, 7 Aug 2015 09:25:48 +0530
Message-ID: <CAKfKVtHPYqB1zjRad2=_xe9LEAuWs8PipNHHC5eUfW=XwChT2A@mail.gmail.com>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
	<1437434050-32907-1-git-send-email-xander.huff@ni.com>
	<55B231DE.4080308@metafoo.de>
	<CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ@mail.gmail.com>
	<55C0722C.7080904@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org,
	Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org, nathan.sullivan-acOepvfBmUk@public.gmane.org,
	jaeden.amero-acOepvfBmUk@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55C0722C.7080904-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Aug 4, 2015 at 1:35 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>
> Well there is no need to use a threaded IRQ. The interrupt handler is quite
> small and doesn't take too much time and doesn't have any delays or sleeps
> in it either.
>
>
Ok thanks for the explanation.
