Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxlvF+2B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E24BD
	for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2023 00:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702542514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ql6CGAoLhvjjLIdaszj6XYwM/l17I70imqN3WyxG7k=;
	b=QxlvF+2BZEOEAcIRa4qoqUvjlzpuNzK3MOibPAus1XiO1IbTaJUIodm/85ax9jcnWvDRyT
	X7aF0aZ3aXNyHBahk8FO1pw1dV1DEj5BxYMGtcYhNDAWNwmK2doEXgp5UyMSkZ/lM76i9u
	PPzHOiMNfkjlhrqkPRriG+6+SBDZAKk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-suNQ_X4BPOmUaZk9AxgwlA-1; Thu, 14 Dec 2023 03:28:31 -0500
X-MC-Unique: suNQ_X4BPOmUaZk9AxgwlA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a0c510419caso207919266b.1
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2023 00:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542510; x=1703147310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ql6CGAoLhvjjLIdaszj6XYwM/l17I70imqN3WyxG7k=;
        b=O7zLRXGQFNVV3Yd7RVxsMiDycHdzCsl+uWXLzknw/PfSufAGN84c+5RVNNcE+Qg+iu
         XDU8nVv92x/CGVolwLr3tzYgH31ILrY/f5+o4lrZoALiE5iUF6NOHyMQS0fMG02I2UqK
         vtPeDKMriQN8YIyozQ2C7SZgu5wThP0rH2AHrrkcfPGgmVqnp5afs4DyCq95nhJ945Zw
         nUeNaH1hov0cfpKx1zqI29orWH0frdmtDKr6gx8KFjq38JFFle5oOSNb+Y3Ai7yAJmCL
         /2OCBF9fn+D8/cV5MJ9Z+QgX3GzloWgcoWc31/in5ZJ+JE8CYkwlvVwaKVl+JF+n8wJG
         y5qg==
X-Gm-Message-State: AOJu0YzVHRupzUQLoHMOcVZ7/1JVaS8fH/BecTgbtpNV5R4eJeB+/Pj7
	t/XBLiwahn6XlUMBfvQNQuJfNf+6615Sv+mvdC2N6o9XozrE3sxlNw666iELmMRqtcQbyYFQVDt
	sSxKCYmNjH4Jyk7XRR8HQdlsIb3HE8yKRmHytZ4kzNaUqApKU+NKz+g==
X-Received: by 2002:a17:906:690:b0:a19:a1ba:8ceb with SMTP id u16-20020a170906069000b00a19a1ba8cebmr3907440ejb.137.1702542510503;
        Thu, 14 Dec 2023 00:28:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6yhbksCdnNsb9qlN+pSvgXQt0kXnWcMUn/hfPM2A642CSLarWttprU9RdQDWN5oi3XfIkmPfmekg8iBVZI/k=
X-Received: by 2002:a17:906:690:b0:a19:a1ba:8ceb with SMTP id
 u16-20020a170906069000b00a19a1ba8cebmr3907438ejb.137.1702542510242; Thu, 14
 Dec 2023 00:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129093457.17984-1-tglozar@redhat.com> <20231129093457.17984-4-tglozar@redhat.com>
 <2ba0bf80-818c-6277-1a3c-f8e007a738ff@redhat.com>
In-Reply-To: <2ba0bf80-818c-6277-1a3c-f8e007a738ff@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 14 Dec 2023 09:28:19 +0100
Message-ID: <CAP4=nvQcqF+mfvdaM8tUChBH9TXM8LNJ6FbiKL+e1SViAE519w@mail.gmail.com>
Subject: Re: [PATCH 3/4] rteval: Convert CpuList class to a module
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 12. 2023 v 22:46 odes=C3=ADlatel John Kacur <jkacur@redhat.com>=
 napsal:
>
> You don't have to do it in this patch, but some builtin testing would be
> nice under this
> if __name__ =3D=3D "__main__":
>

Yeah that's definitely a good idea, moving the cpulist logic into a
separate module will allow for more elegant unit tests directly in the
file.

In the future, we might also consider moving tests into separate files
using some kind of unit test library like pytest [1] or the builtin
unit test [2] module. If I understand it correctly, currently you have
to run tests manually for each module that has them, and you also have
to check the results manually; changing that to a more systematic and
automated approach should make development easier and prevent bugs.

[1] - https://docs.pytest.org/en/7.4.x/
[2] - https://docs.python.org/3/library/unittest.html

Tomas

