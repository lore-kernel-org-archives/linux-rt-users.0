From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 3/3] remove license info containing an old FSF
 address
Date: Mon, 5 Oct 2015 21:52:40 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510052150570.14006@riemann>
References: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de> <1444071917-1450-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-829403202-1444074762=:14006"
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33670 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbbJETwq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 15:52:46 -0400
Received: by wiclk2 with SMTP id lk2so136776484wic.0
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 12:52:43 -0700 (PDT)
In-Reply-To: <1444071917-1450-3-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-829403202-1444074762=:14006
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Mon, 5 Oct 2015, Uwe Kleine-König wrote:

> The source tree contains the complete GPL so that paragraph isn't that
> useful.
> 
> I didn't touch src/pi_tests/tst-mutexpi10.c (which is borrowed verbatim
> from libc AFAIK) and the references containing the correct address of
> the FSF.
> ---
>  src/backfire/backfire.c               | 5 -----
>  src/backfire/sendme.c                 | 5 -----
>  src/pmqtest/pmqtest.c                 | 5 -----
>  src/ptsematest/ptsematest.c           | 5 -----
>  src/rt-migrate-test/rt-migrate-test.c | 4 ----
>  src/sigwaittest/sigwaittest.c         | 5 -----
>  src/svsematest/svsematest.c           | 5 -----
>  7 files changed, 34 deletions(-)
> 
> diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
> index aaf9c4af8e00..eb13998b8fed 100644
> --- a/src/backfire/backfire.c
> +++ b/src/backfire/backfire.c
> @@ -12,11 +12,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
> - * USA.
>   */
>  
>  #include <linux/module.h>
> diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
> index c1854d9660cb..8befffcbc722 100644
> --- a/src/backfire/sendme.c
> +++ b/src/backfire/sendme.c
> @@ -12,11 +12,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
> - * USA.
>   */
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 75d5ee8185a0..bd66a6fb5106 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -12,11 +12,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
> - * USA.
>   */
>  
>  #include <stdio.h>
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index a31c745ec928..15d037d11fff 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -12,11 +12,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
> - * USA.
>   */
>  
>  #include <stdio.h>
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index d7b68ddac3e5..72e02610cf22 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -14,10 +14,6 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   */
>  #ifndef _GNU_SOURCE
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 91fcdaa5f185..aafce38d3d48 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -12,11 +12,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
> - * USA.
>   */
>  
>  #include <stdio.h>
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index eeb82858720a..13e5042813c4 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -12,11 +12,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
> - * USA.
>   */
>  
>  #include <stdio.h>
> -- 
> 2.1.4
> 

You can correct the address if you want to, but IANL, but if the Free 
Software Foundation says you should put that at the top of the file, I 
don't think you can just decide for yourself that you don't need to, just 
because you know you are doing the right thing by including a copy of the 
licence.

Thanks
John
---1463804494-829403202-1444074762=:14006--
