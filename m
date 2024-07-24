Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060216EB72
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832383; cv=none; b=M3K7UDuJjJljNp4lME/MiIDqxItYLeUbcACF+zCrIxVGo9HvVR9AMj1Y1UWrYwjqM+1AErlRhGMjpP3Z6qkk+ezaEc//l3ZZpQTkSwRY5FC9pDnr5yJTx8K/1z/neH0psV+jY67EMnl7sr2U25zQ1gjaPiRHglUi1/sDPVb/u8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832383; c=relaxed/simple;
	bh=XEW45NsvTTHHceJrJrCZudwLFFUxvY5a/Qj+wSKbZzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okJWfILCOqKXXBH0FHBvJmDDhmF4wvdCrGr3m4teyy4H3XOKFlXHyyQcPJBt3PYyoBGbjMKUUuaByrKHZ5upDhVMKUMwZVtuowuKAnWxLpSBDjqlGUXVZqzYV1UZ5pRSGgTyDXR4ssbellcJxM2KKbl/Ap/P5iYp/V648KwmeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com; spf=fail smtp.mailfrom=sidebranch.com; dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b=qwvT+d0l; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b="qwvT+d0l"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so739434a91.0
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidebranch-com.20230601.gappssmtp.com; s=20230601; t=1721832380; x=1722437180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEW45NsvTTHHceJrJrCZudwLFFUxvY5a/Qj+wSKbZzE=;
        b=qwvT+d0lpOtq0NB4s/uDw5JLl4pnLlk5szU8GYuqMT3xq9r8hX5vFcJ6XTP5B3C0uk
         eQ6/WWb3xn2xOpIKyRaAbml5f+ezxeiDU6Qn66wRqgpc3AvQ7nE/w2QN8CnPeswzcnkF
         El/QWt6pIWSJYCd61laLtPZQJ8isu8SWVoTRzU4m0i87QRdaDABeExDOb8vBLcGzt5t9
         eKUycCLTJz3qPagKiFtpdktvaTWyVGARJ+DcMY5Zk2EcF71cNhE0wX/R1mxYQk9eSoym
         hwSWBl4t9mAKSNzEyTsUgY9vPR7EBkyGvWjLkT7111l7QVGP74nsNETGb0NIqqF9yxrd
         DPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721832380; x=1722437180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEW45NsvTTHHceJrJrCZudwLFFUxvY5a/Qj+wSKbZzE=;
        b=tDPzk71C8fGIlcODgJExlyoKIcTh4nstgaX+cHQIXkYL73VQAaKDDDdNj2AiJHUz8e
         4YqZWJh24thOgkuZqYax3p03yMRNlmCvPZGyEzVqSJ+WZ/3mX/Z8DeGtpLiAfPnc1+pR
         EVKLBkSMsxwineSMt7hoK+bDSgaRT1aVv4CNDz46L609w24C1TarGy5NjH7h6j+xbgyg
         lPHEUfv5rvm3weWuDHXPAkZQHYD+6eddlhMvIkgcbE3aKthpJ+FtuANN2X3iZjkspnkK
         NForR86HTEcBSYXbPrr28AkMJIx/anLlYG5/HFwtA6S5wL+s/2/tUHOJR/RRbaQikAH1
         /RlA==
X-Gm-Message-State: AOJu0YxbGXmAfHg0nJQvOfC63KVfU4ruJcK6/bZ56HIPg51CFMLb/X7k
	5y/S3l0+Fdg7XZ0JUk0iS3ralIfzenSfIWN6WPfu89uTCvPLWOw9KHgIhDCU/Hwi43cNlgWVncO
	d+WKBNmpybptxn/vwlTC+KeHb81gpB+Q5xMa6fA==
X-Google-Smtp-Source: AGHT+IGqOkfdWI+23bkR0Wr2b6kIrdNnXPE1xuC4ZOJeq0TjFKJgFEBA4iWF/WL5JhfnPq01EUFjzvHxSbZYxUCsRuI=
X-Received: by 2002:a17:90a:108:b0:2c3:2f5a:17d4 with SMTP id
 98e67ed59e1d1-2cdb9397b29mr3545151a91.4.1721832379942; Wed, 24 Jul 2024
 07:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMjhiJiqfz67Aba8KAKTHjO7TjGADvM2S0qDVrGfF+XkT5DeAw@mail.gmail.com>
 <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com>
In-Reply-To: <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com>
From: Leon Woestenberg <leon@sidebranch.com>
Date: Wed, 24 Jul 2024 16:46:08 +0200
Message-ID: <CAMjhiJhZQvr1qEdUm3T2v=JDETO4iWjjo5Lfc=XQgkm4yPwXtg@mail.gmail.com>
Subject: Re: rcuc/ thread on isolated CPU
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, Jul 24, 2024 at 4:35=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le mer. 24 juil. 2024 =C3=A0 16:06, Leon Woestenberg <leon@sidebranch.com=
> a =C3=A9crit :
> > CPUs." and also tried with rcutree.nohz_full_patience_delay=3D1000.
> Are you sure you have the proper patch applied? It is not yet upstream:
>
Thanks, no, I did not even have this patch installed.
I wasn't reading well, I didn't understand that the option was
actually implemented by the discussed patch.

Thanks, Leon.
