Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB84C4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 07:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619AA21E6F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 07:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391832AbfIQHV2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:21:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40785 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfIQHV1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 03:21:27 -0400
Received: from [5.158.153.52] (helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1iA7nh-0004r3-Ju; Tue, 17 Sep 2019 09:21:25 +0200
Date:   Tue, 17 Sep 2019 09:21:25 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 2/4] rt-tests: cyclictest: Make tracemark work correctly
 again
Message-ID: <20190917072125.GA2613@linutronix.de>
References: <20190916215111.10193-1-jkacur@redhat.com>
 <20190916215111.10193-2-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20190916215111.10193-2-jkacur@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi John,

On Mon, Sep 16, 2019 at 11:51:09PM +0200, John Kacur wrote:
> commit f5ccfbe4d6641e48f56152be135d901dd31cba7e
> was a little too aggressive removing ftrace code.
>
> We were able to remove ftrace code because this functionality is
> available using trace-cmd, in conjunction with the tracemark option in
> cyclictest. Put back the parts of tracemark needed to make this work
> correctly.
>
> After this patch you can get tracing info like this as an example.
>
> trace-cmd record -p function ./cyclictest -t -b100 --tracemark
>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 52f93da7d074..45b6041ec1c9 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -184,6 +184,7 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts);
>
>  static int shutdown;
>  static int tracelimit = 0;
> +static int trace_marker = 9;

Shouldn't this be 'static int trace_marker = 0'? Otherwise it's always set.

Thanks,
Kurt

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl2AiWwACgkQeSpbgcuY
8KbynBAAp0H6N2DOhzJUlKXVl1R7pbN2IJgBn/84fcXX5BTlWEqDcOIVHpmVw/sc
V+afFs3WN0tUlkTc6bW7/yutsbmMtIXZQ/R+nsecK5W1jKIoPqveyj1R5wwmqE+J
esV/u7fNFjBIs6HKuyNqSXsGRNBuOQCXWcfxCp7TocIBnUEInlma82c9yJaLEjER
UoRACaGR3b2SUJVqVXej82prYGXVVgRqmHxjt0eZTKBDS1wi1xw/ZF/M5bDQVwV5
hsIIrerSoc59dqcsJHNNYShAAHzU2yv0C6YgX9486jAcrlLgU9T6duxNxKxHxR3d
u/ihIM7OAuknNhP+Rhd2XqqJtIwVlFtJJsQCOZBYeXA23sXTbh+ipbuSEb4hdk9q
Lcv436C3mndM3CSZqhauX0ocaVgeYGv94KwQgT86hzXhOoWmso9CoYlbR6gF7n6O
otLrW3ynx/LS3DXhl2/eD0EcHztq7tjCXPD54PUU1cN42mySFI0GuIsdJcB4MPqN
UxbA+TCHsjzuqY/drJUvDzgC7ZezeuUUOOGOam15DbPiFDIBrq6kud7w8kAOBZ+u
S7Auwp81Z7rq7UmnjHCV2EQtHU0g6qeGZn+W3K5SzZP4DcuPXuxemp+Rx6dVk4Yp
XSXPn5hmdq1ikWWFl8JQ5EWfM8UkYaILh5ghf9z63cvwzAkJfO0=
=yxI7
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
