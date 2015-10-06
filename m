From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH rt-tests 3/3] remove license info containing an old FSF
 address
Date: Tue, 6 Oct 2015 09:01:00 +0200
Message-ID: <20151006070100.GF3982@pengutronix.de>
References: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444071917-1450-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <alpine.LFD.2.20.1510052150570.14006@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46615 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbJFHBE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 03:01:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1510052150570.14006@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Mon, Oct 05, 2015 at 09:52:40PM +0200, John Kacur wrote:
> On Mon, 5 Oct 2015, Uwe Kleine-K=F6nig wrote:
>=20
> > The source tree contains the complete GPL so that paragraph isn't t=
hat
> > useful.
>=20
> You can correct the address if you want to, but IANL, but if the Free=
=20
> Software Foundation says you should put that at the top of the file, =
I=20
> don't think you can just decide for yourself that you don't need to, =
just=20
> because you know you are doing the right thing by including a copy of=
 the=20
> licence.

I'm not a lawyer either just applied common sense (or what I think is
common sense). For GPL-3 the address isn't included any more, there it'=
s
just:

	You should have received a copy of the GNU General Public
	License along with this program.  If not, see
	<http://www.gnu.org/licenses/>.

And I understand that snippet as an example. After all it also
recommends to say "either version 2 of the License, or (at your option)
any later version." which isn't used everywhere either.

And given that correcting the address now make us correct the address
once more when the FSF moves the next time I still think dropping wrong
addresses is the right thing to do.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
