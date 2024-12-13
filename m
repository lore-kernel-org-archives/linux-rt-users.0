Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF915383B
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Dec 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071747; cv=none; b=cJU6bgRRSHDi2Pw0SmaLZTiSYwRwy2qVcvxt3sxEzmYKXBlOlpfL7s+5iul+HXATJIuH2IFhpPShBNrlmKR4489kn2I29P4lBkH19WVq5VFaNwORRjimLWjCj11KNCPnzeLUNIozH2O69UkDtBfx3Px9vUGW7l9fyuI+eXd8mwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071747; c=relaxed/simple;
	bh=X3TETxu1itTdopLYdvSEyhM9wKoVHojthtRdxes6I5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bFbSojKjTNc3Yq7qmnqOPI7k/fXanyk/dxAfsChEOvea2dsDtIkbOLPv/SEx1H9zCNC7JJyg2SeU0ZVaisQfAz9unic/SsxJ0/M3z0SMKMS7rbQ8AykM3meaaW8pOF71cEWTl7AcSnIShD691Fumy75IrNHpzEl3/Ieus5Z+c10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjAnCsFS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjAnCsFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734071744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZm9qM1V937BchILtZLOe9uTfMfj2tw7tDc13Yus8Ms=;
	b=KjAnCsFSZo3QigAm2IsyYd2TvYWTZTOf8YLDd89aCTgt+Q0sATEaI14+ke8zkYtkC/0fdS
	ZJEFDPK8DC5vBakds4iH5/n1RZK0NsAjeqvz5l8Bi9+zYmrmDVXDqI6j6MMsMrAKyNyf5r
	lP62cNkBB8T8RaU7iZz4J76xsCDytQI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-U_-pBDShO3q6tvfNJCashg-1; Fri, 13 Dec 2024 01:35:42 -0500
X-MC-Unique: U_-pBDShO3q6tvfNJCashg-1
X-Mimecast-MFC-AGG-ID: U_-pBDShO3q6tvfNJCashg
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844e9b92401so57698039f.1
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 22:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734071742; x=1734676542;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZm9qM1V937BchILtZLOe9uTfMfj2tw7tDc13Yus8Ms=;
        b=W9nfBJS2oyCcQSbtDYp5giSqVVunrqusAtzHWN+A5VtJG3K+zuLdBHwQaeN5ojctrt
         6fpueB8UQ3E4oI0LbP1Hs1ot+HHOhD1nkZ6dVeWLyHlCJT/cqsv/0AuCpQyB2PooG3IS
         1+xLYofmMS3sudRJ/dYuNXr4b5jKNbvAORGaBsh+T/F/cqYEGFmdn1hlqgZYo/Z+/TV5
         PU7yei97WaYyay4BLm67kXEqCQBFb3NAFHsGZYrNUkLqIAYJDKIceaw4P66ZzA713iF2
         +Dg+bzevS+W8ElTvKgp9JazfvIZhQwYng6XRnqB1U2g44wXT75SyrO84zsg65OvoS3L0
         gdxw==
X-Forwarded-Encrypted: i=1; AJvYcCVhGPEYyFD9I/yKvURdtF/pWYaFWCAIGqzjidKlaD7j3xHyvyrpsmuOhOTQVlR3cs6ZCpoiLCg+VhVh+WyWtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pzxfDzIxaL6+18B+vwrYDAAJNuEU2hf82WtJmqFjxOQdwjTT
	RQjOoX/b6DjbTPubGDVKqk14X4aKdJD9U5roemQ4D/bNVPasz9bDQr1Icr7aaVkToJwH4qcgSK4
	+bZMAKa/hBZMBUhR4cC5obMWGvK2Av5xptQxk9r4VeUfaSj84cO8Zn0t4zXciC+rI
X-Gm-Gg: ASbGncsFmX4kCmJ2wDf5g70leneohXE0n+Uqq+Ihkj2rUbit7zvy6Lrfhy4cgByU0dB
	lWOcewK92GE4PthsESpcld0fzE0Xbk3Puq/YE/H5N5/VnnuP6JpM2dLYvAgsbztg/Ut2EtKDlJ3
	ekimNJVrHywvK3wQWdKA3I87o5/cOJdYMmDePh2RMRDfcTTNeR1DXWvEZqkJ8XBB6P9jLZTncqo
	2FHP4lzVJPgsmamP0+2cK5xhbGVgCBWayJwYx43RLEWIOpvInTmnoCVU+yKslHj89boghdk7/7/
	Q/490rS56AA0
X-Received: by 2002:a05:6e02:1948:b0:3a7:8c3f:edce with SMTP id e9e14a558f8ab-3aff4619adamr17823115ab.3.1734071742154;
        Thu, 12 Dec 2024 22:35:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsT7yQAYq6GdLOx/o7W3JZm+5Gb9hQIX/AoGljrHmXd4Gu+dG2c3Y4gZIflKAtVA0iMq0dMw==
X-Received: by 2002:a05:6e02:1948:b0:3a7:8c3f:edce with SMTP id e9e14a558f8ab-3aff4619adamr17822955ab.3.1734071741887;
        Thu, 12 Dec 2024 22:35:41 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2df658c4csm1110332173.145.2024.12.12.22.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 22:35:41 -0800 (PST)
Message-ID: <afa631a73622f8b0d49dbe4608764b353841f472.camel@redhat.com>
Subject: Re: [1/1] rt-tests: cyclictest: Suppress unused parameter warnings
From: Crystal Wood <crwood@redhat.com>
To: ende.tan@starfivetech.com, linux-rt-users@vger.kernel.org, 
	mtosatti@redhat.com
Cc: williams@redhat.com, jkacur@redhat.com, leyfoon.tan@starfivetech.com, 
	endeneer@gmail.com
Date: Fri, 13 Dec 2024 00:35:40 -0600
In-Reply-To: <20241212162453.2618945-1-ende.tan@starfivetech.com>
References: <20241212162453.2618945-1-ende.tan@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 00:24 +0800, ende.tan@starfivetech.com wrote:
> From: Tan En De <ende.tan@starfivetech.com>
>=20
> Mark unused parameters with `__attribute__((unused))`.
>=20
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
>  src/cyclictest/cyclictest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Can we just turn off this warning?  Unused parameters are entirely
normal in functions used as callbacks as well as with ifdefs, and it
seems like a low value warning to begin with (there's a reason it's not
in -Wall).


-Crystal

