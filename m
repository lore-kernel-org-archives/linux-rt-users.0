Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M58apNoc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67F6B9
	for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2023 00:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702541352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8Dml4THeBIcIr8U8OO/Kb9Yeg+qxdtD8lSB3p5ekjs=;
	b=M58apNocXvGdvH4wJE0JDxDIU47VBQcrQb4NVsBERWtMUG/QK+z+YglGovIeuzl/mmwLnT
	zqnlzu9owhxS4sa+nHW5c6u+ttcWythVXlTmeQ+02XXMlANNIO3+EYut/J7ztbUeH4rnRl
	gxxl2VzI+XACsQjZ3AsrD6lMzItQh9k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-F60esVgGPBCwuFfruL4UAQ-1; Thu, 14 Dec 2023 03:09:11 -0500
X-MC-Unique: F60esVgGPBCwuFfruL4UAQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1db7b26269so462040266b.0
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2023 00:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541350; x=1703146150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8Dml4THeBIcIr8U8OO/Kb9Yeg+qxdtD8lSB3p5ekjs=;
        b=lYMrUx5ABazN+9h3DhNAQ1qQXyn9bdLPHd4A33JPXABzMyVX5ETSOyRpLs4GQ7gh/Y
         IjxmNmwCJTlvUAkRLfEtRkX3scHxApy/oUywp1sF3KPiIhAHGWWYeOYsFAkHMtTplJ9k
         byr9pLZ8+k0vmmbnt/TU/6z0kAueNKp7gq3OzBZzTe1ruT8AcUshaOL3V+nIdkONlKPE
         WP1hzj88d0SL1ZbY4U4u2TioCPnOZ7VwGhlreG4oz9BOfihY7uLOwYyj01AebN83O+TJ
         fzFZ6Vy6ZGtIACF067TtDPbl1mMcJNup8Dp2zeeSaZShJEWlMKW6wBd8WatTvysQaauE
         ot/w==
X-Gm-Message-State: AOJu0YwPdC9yRk/uoBo5geT58z+QUzze2k3NRIeeX1WjGgRY+lrzvDLy
	MZ2fejWt9mPmdeUyuw/DihZoRmLXOUiRWO9DUa/JrUc7RofKlSk5jKLtMX0mSAFlo11C+3JHFEH
	Ca2uW3HVAO45c8UroCJnP3rzScBKspmaiOW5qcHYVJD9mtW42XHKSuA==
X-Received: by 2002:a17:906:5346:b0:a02:a2cc:66b8 with SMTP id j6-20020a170906534600b00a02a2cc66b8mr4560603ejo.14.1702541350042;
        Thu, 14 Dec 2023 00:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU0ajE+kj2sEBZ2jYrSVMqvjT+y0O3osIBEhOvccHhnIuXzQOyH2DFgc7YfZlUVDYFoTst9aFOrwbZiINwNYk=
X-Received: by 2002:a17:906:5346:b0:a02:a2cc:66b8 with SMTP id
 j6-20020a170906534600b00a02a2cc66b8mr4560595ejo.14.1702541349752; Thu, 14 Dec
 2023 00:09:09 -0800 (PST)
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
Date: Thu, 14 Dec 2023 09:08:58 +0100
Message-ID: <CAP4=nvTu9C2rCvze8ARV7Ynmor0d9ExK_jzkXaOv5UOofjotdQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] rteval: Convert CpuList class to a module
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 12. 2023 v 22:46 odes=C3=ADlatel John Kacur <jkacur@redhat.com>=
 napsal:
>
> If you're removing the CpuList class then CpuList, or Cpulist is availabl=
e
> instead of cpulist_utils
>

cpulist_utils is a module, unlike CpuList which is a class; these have
different spelling conventions for case, see
https://peps.python.org/pep-0008/#package-and-module-names.

>
> Instead of removing these, you could change them to
>
> compress_cpulist =3D cpulist_utils.compress_cpulist
> expand_cpulist =3D cpulist_utils.expand_cpulist
>
> and then you don't need to make all of the rest of
> the related changes in the file
>

Or I could directly import them like this:
from rteval.cpulist_utils import compress_cpulist, expand_cpulist

The reason why I did the change like this was that I wanted the usage
of cpulist_utils functions to be consistent throughout the entire
rteval source code. In systopology.py and other files, CpuList.* is
used directly (which became cpulist_utils.* in this patch).

Tomas

