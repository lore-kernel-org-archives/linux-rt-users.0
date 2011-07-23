From: hermann <brummer--S0/GAf8tV78@public.gmane.org>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Sat, 23 Jul 2011 16:19:13 +0200
Message-ID: <1311430753.2223.5.camel@box>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>
	<1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1311313414.2940.8.camel@box> <20110722065711.GD16561@pengutronix.de>
	<87y5zqzick.fsf@rustcorp.com.au>
	<20110722192051.GH16561@pengutronix.de>
	<1311391059.2343.8.camel@box>  <4E2A9B18.6030000@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: lguest-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
To: Robin Gareus <robin-+VlDMftONaMdnm+yROfE0A@public.gmane.org>
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4E2A9B18.6030000-+VlDMftONaMdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/lguest>,
	<mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/lguest>,
	<mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Am Samstag, den 23.07.2011, 11:57 +0200 schrieb Robin Gareus:
> Hello Herman,
> 
> Are you using make-kpkg?  You need to change the path to lguest
> in /usr/share/kernel-package/ruleset/targets/doc.mk and two or three
> other files there as Rusty outlined.
> 
> HTH,
> robin 

Hi Robin

Yes, using make-kpkg. I changed line 61 from 

rm -f $(DOCDIR)/Documentation/lguest/lguest
$(DOCDIR)/Documentation/lguest/lguest.lds

to 

rm -f $(DOCDIR)/Documentation/virtual/lguest/lguest
$(DOCDIR)/Documentation/virtual/lguest/lguest.lds

but it didn't help, the result is still the same.
/usr/bin/make    ARCH=i386 \
			     -C Documentation/lguest
make: *** Documentation/lguest: Datei oder Verzeichnis nicht gefunden.
Schluss.

Could you wrote a bit more precise what needs to do, please ?

regards
hermann
