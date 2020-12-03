function dot = realSymDot(v1,v2)

v1f = formula(v1);
v2f = formula(v2);

sizeOfv1 = size(v1f);
sizeOfv2 = size(v2f);

if (sizeOfv1(1)>1 && sizeOfv1(2)>1) || (sizeOfv2(1)>1 && sizeOfv2(2)>1)
    error('どちらもベクトルである必要があります')
end
if numel(v1f)~=numel(v2f)
    errorMException('The sizes do not match')
end

dot = sym(0);

for i = 1:numel(v1f)
    dot = dot + v1f(i)*v2f(i);
end

dot = simplify(dot);

end
