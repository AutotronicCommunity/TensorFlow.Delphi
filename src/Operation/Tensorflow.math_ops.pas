unit Tensorflow.math_ops;
(*****************************************************************************
   Copyright 2018 The TensorFlow.NET Authors. All Rights Reserved.
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
******************************************************************************)
{$WARN IMPLICIT_STRING_CAST OFF}
{$WARN IMPLICIT_STRING_CAST_LOSS OFF}

interface
    uses System.SysUtils,
         Spring,
         TF4D.Core.CApi,
         TensorFlow.DApi,
         Numpy.Axis,

         TensorFlow.Context,
         TensorFlow.Variable ;

type
    math_ops = record
     private
      class function _truediv_python3(x: TFTensor; y: TFTensor; name: string = ''): TFTensor;static;
      class function _ReductionDims(x, axis: TFTensor): TFTensor; overload; static;
      class function _ReductionDims(x: TFTensor; axis: TAxis) : TFTensor; overload; static;
      class function _may_reduce_to_scalar(keepdims: Boolean; axis: PAxis;    _output: TFTensor): TFTensor; overload; static;
      class function _may_reduce_to_scalar(keepdims: Boolean; axis: TFTensor; _output: TFTensor) : TFTensor;  overload; static;
      class function _may_reduce_to_scalar(keepdims: Boolean; axis: Integer;  _output: TFTensor): TFTensor;  overload; static;
      /// <summary>
      /// Casts a tensor to type `int32`.
      /// </summary>
      /// <param name="x">A `Tensor` or `SparseTensor` or `IndexedSlices`.</param>
      /// <param name="name">A name for the operation (optional).</param>
      /// <returns>A `Tensor` or `SparseTensor` or `IndexedSlices` with same shape as `x` with type `int32`.</returns>
      class function to_int32(x : TFTensor; name: string = 'ToInt32') : TFTensor; static;
     public
      class function cast(x: TFTensor;         dtype: TF_DataType = DtInvalid; name : string = ''): TFTensor;overload; static;
      class function cast(x: IVariableV1;      dtype: TF_DataType = DtInvalid; name : string = ''): TFTensor;overload; static;
      class function cast(x: ResourceVariable; dtype: TF_DataType = DtInvalid; name : string = ''): ResourceVariable;overload; static;
      class function add<Tx, Ty>(x: Tx; y: Ty; name: string = '') : TFTensor; static;
      class function add_v2(x: TFTensor; y: TFTensor; name: string = ''): TFTensor;overload;static;
      class function add_v2<Tx, Ty>(x: Tx; y: Ty; name: string = '') :TFTensor; overload;static;
      /// <summary>
      /// Divide two values using Python 2 semantics. Used for Tensor.__div__.
      /// </summary>
      /// <param name="x">`Tensor` numerator of real numeric type.</param>
      /// <param name="y">`Tensor` denominator of real numeric type.</param>
      /// <param name="name">A name for the operation</param>
      /// <returns>`x / y` returns the quotient of x and y.</returns>
      class function &div(x: TFTensor; y: TFTensor; name: string = ''): TFTensor; static;
      class function truediv(x: TFTensor; y: TFTensor; name: string = ''): TFTensor;static;
      class function multiply(x: TFTensor; y: TFTensor; name: string = ''): TFTensor;overload; static;
      class function multiply<Tx, Ty>(x: Tx; y: Ty; name : string = ''): TFTensor; overload; static;
      /// <summary>
      /// Multiplies matrix `a` by matrix `b`, producing `a` * `b`.
      /// </summary>
      /// <param name="a"></param>
      /// <param name="b"></param>
      /// <param name="transpose_a">If `True`, `a` is transposed before multiplication.</param>
      /// <param name="transpose_b">If `True`, `b` is transposed before multiplication.</param>
      /// <param name="adjoint_a">If `True`, `a` is conjugated and transposed before multiplication.</param>
      /// <param name="adjoint_b">If `True`, `b` is conjugated and transposed before multiplication.</param>
      /// <param name="a_is_sparse">If `True`, `a` is treated as a sparse matrix.</param>
      /// <param name="b_is_sparse">If `True`, `b` is treated as a sparse matrix.</param>
      /// <param name="name">Name for the operation (optional).</param>
      /// <returns>
      /// A `Tensor` of the same type as `a` and `b` where each inner-most matrix is
      /// the product of the corresponding matrices in `a` and `b`, e.g. if all
      /// transpose or adjoint attributes are `False`:
      /// </returns>
      class function matmul(a: TFTensor; b: TFTensor;
                             transpose_a : Boolean = false; transpose_b : Boolean= false;
                             adjoint_a   : Boolean = false; adjoint_b   : Boolean= false;
                             a_is_sparse : Boolean = false; b_is_sparse : Boolean= false;
                             name: string = ''): TFTensor; overload;static;
      class function matmul(a: TFTensor; b: TFTensor; name: string): TFTensor; overload;static;
      /// <summary>
      /// Returns the complex conjugate of a complex number.
      /// </summary>
      /// <param name="x">`Tensor` to conjugate.  Must have numeric or variant type.</param>
      /// <param name="name">A name for the operation (optional).</param>
      /// <returns>A `Tensor` that is the conjugate of `x` (with the same type).</returns>
      class function conj(x: TFTensor; name: string = ''): TFTensor; static;
      class function equal<Tx, Ty>(x: Tx; y: Ty; name : string= ''): TFTensor; static;
      class function not_equal<Tx, Ty>(x: Tx; y: Ty; name : string= '') : TFTensor; static;
      class function range(start: TValue; limit: PValue= nil; delta: PValue= nil; dtype: TF_DataType= DtInvalid; name: string = 'range'): TFTensor; static;
      class function reduce_sum(input_tensor: TFTensor; axis : TFTensor = nil; keepdims: Boolean = false; name: string = ''): TFTensor; static;
      class function pow<Tx, Ty>(x: Tx; y: Ty; name: string = '') : TFTensor; static;
      class function logical_and(x: TFTensor; y: TFTensor; name: string = ''): TFTensor; static;

      class function abs(x: TFTensor; name: string = ''): TFTensor; static;
      /// <summary>
      /// Adds all input tensors element-wise.
      /// </summary>
      /// <param name="inputs"></param>
      /// <param name="name"></param>
      /// <returns></returns>
      class function add_n(inputs: TArray<TFTensor>; name : string = ''): TFTensor; static;
      class function argmax(input: TFTensor; dimension: TAxis; output_type: TF_DataType = TF_INT64; name : string = ''): TFTensor; static;
      class function Round(x: TFTensor; name : string = ''): TFTensor; static;
      class function cos(x : TFTensor; name : string = ''): TFTensor; static;
      class function saturate_cast(value: TFTensor; dtype: TF_DataType; name : string = ''): TFTensor; static;
      class function cumsum<T>(x : TFTensor; axis: T; exclusive: Boolean = false; reverse: Boolean = false; name : string = ''): TFTensor; static;
      /// <summary>
      /// Computes Psi, the derivative of Lgamma (the log of the absolute value of
      /// `Gamma(x)`), element-wise.
      /// </summary>
      /// <param name="x"></param>
      /// <param name="name"></param>
      /// <returns></returns>
      class function digamma(x : TFTensor; name : string = ''): TFTensor; static;
      /// <summary>
      ///    Returns 0 if the denominator is zero.
      /// </summary>
      /// <param name="x">
      /// </param>
      /// <param name="y">
      /// </param>
      /// <param name="name">
      /// If specified, the created operation in the graph will be this one, otherwise it will be named 'DivNoNan'.
      /// </param>
      /// <returns>
      ///    The Operation can be fetched from the resulting Tensor, by fetching the Operation property from the result.
      /// </returns>
      /// <remarks>
      ///
      ///    *NOTE*: <c>DivNoNan</c> supports broadcasting. More about broadcasting
      ///    [here](http://docs.scipy.org/doc/numpy/user/basics.broadcasting.html)
      /// </remarks>
      class function div_no_nan(x : TFTensor; y: TFTensor; name : string = ''): TFTensor; static;
      class function einsum(equation: string; inputs: TFTensors; name : string = ''): TFTensor; static;
      class function greater_equal<Tx, Ty>(x: Tx; y: Ty; name : string = ''): TFTensor; static;
      /// <summary>
      /// Computes the Gauss error function of `x` element-wise.
      /// </summary>
      /// <param name="x"></param>
      /// <param name="name"></param>
      /// <returns></returns>
      class function erf(x : TFTensor; name : string = ''): TFTensor; static;
      class function sqrt(x : TFTensor; name : string = ''): TFTensor; static;
      class function mul_no_nan<Tx, Ty>(x: Tx; y: Ty; name : string = ''): TFTensor; static;
      class function scalar_mul<Tscale, Tx>(scale: Tscale; x: Tx; name : string = ''): TFTensor; static;
      class function real(input: TFTensor; name : string = ''): TFTensor; static;
      /// <summary>
      /// Computes the mean of elements across dimensions of a tensor.
      /// Reduces `input_tensor` along the dimensions given in `axis`.
      /// Unless `keepdims` is true, the rank of the tensor is reduced by 1 for each
      /// entry in `axis`. If `keepdims` is true, the reduced dimensionsare retained with length 1.
      /// If `axis` is None, all dimensions are reduced, and a tensor with a single element is returned.
      /// </summary>
      /// <param name="input_tensor"> The tensor to reduce. Should have numeric type.</param>
      /// <param name="axis">The dimensions to reduce. If `None` (the default), reduces all
      /// dimensions.Must be in the range `[-rank(input_tensor), rank(input_tensor))`.</param>
      /// <param name="keepdims"> If true, retains reduced dimensions with length 1.</param>
      /// <param name="name"> A name for the operation (optional).</param>
      class function reduce_mean(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''; reduction_indices: PInteger = nil): TFTensor; static;
      /// <summary>
      /// Computes the product of elements across dimensions of a tensor.
      /// </summary>
      /// <param name="input_tensor"></param>
      /// <param name="axis"></param>
      /// <param name="keepdims"></param>
      /// <param name="name"></param>
      /// <returns></returns>
      class function reduce_prod(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''): TFTensor; static;
      class function reduce_std(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''): TFTensor; static;
      class function reduce_variance(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''): TFTensor; static;
      /// <summary>
      /// Computes the "logical and" of elements across dimensions of a tensor.
      /// </summary>
      /// <param name="input_tensor"></param>
      /// <param name="axis"></param>
      /// <param name="keepdims"></param>
      /// <param name="name"></param>
      /// <returns></returns>
      class function reduce_all(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''): TFTensor; static;
      /// <summary>
      /// Computes log(sum(exp(elements across dimensions of a tensor))).
      /// Reduces `input_tensor` along the dimensions given in `axis`.
      /// Unless `keepdims` is true, the rank of the tensor is reduced by 1 for each
      /// entry in `axis`. If `keepdims` is true, the reduced dimensions
      /// are retained with length 1.
      ///
      /// If `axis` has no entries, all dimensions are reduced, and a
      /// tensor with a single element is returned.
      ///
      /// This function is more numerically stable than log(sum(exp(input))). It avoids
      /// overflows caused by taking the exp of large inputs and underflows caused by
      /// taking the log of small inputs.
      /// </summary>
      /// <param name="input_tensor"> The tensor to reduce. Should have numeric type.</param>
      /// <param name="axis"> The dimensions to reduce. If `None` (the default), reduces all
      /// dimensions.Must be in the range `[-rank(input_tensor), rank(input_tensor))`.</param>
      /// <param name="keepdims"></param>
      /// <returns> The reduced tensor.</returns>
      class function reduce_logsumexp(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''): TFTensor; static;
      class function reduce_any(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''): TFTensor; static;
      class function reduce_max(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''): TFTensor; static;
      class function reduce_min(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean = false; name : string= ''): TFTensor; static;
      class function sigmoid<T>(x: T; name : string = ''): TFTensor; static;
      class function sign<T>(x: T; name : string = ''): TFTensor; static;
      class function sin(x : TFTensor; name : string = ''): TFTensor; static;
      /// <summary>
      /// Returns (x - y)(x - y) element-wise.
      /// </summary>
      /// <param name="x"> A `Tensor`. Must be one of the following types: `bfloat16`, `half`, `float32`, `float64`, `int32`, `int64`, `complex64`, `complex128`.</param>
      /// <param name="y"> A `Tensor`. Must have the same type as `x`.</param>
      /// <param name="name"> A name for the operation (optional).</param>
      /// <returns>A `Tensor`. Has the same type as `x`.</returns>
      class function square_difference(x : TFTensor; y: TFTensor; name : string = ''): TFTensor; static;
      class function square(x : TFTensor; name : string = ''): TFTensor; static;
      class function subtract<Tx, Ty>(x: Tx; y: Ty; name : string = ''): TFTensor; static;
      class function log(x : TFTensor; name : string = ''): TFTensor; static;
      class function lgamma(x : TFTensor; name : string = ''): TFTensor; static;
      class function linspace(start: TFTensor; stop: TFTensor; num: Integer = 50; name: string = ''; axis: Integer = 0): TFTensor; static;
      /// <summary>
      /// Helper function for reduction ops.
      /// </summary>
      /// <param name="input_shape">1-D Tensor, the shape of the Tensor being reduced.</param>
      /// <param name="axes">1-D Tensor, the reduction axes.</param>
      /// <returns>A 1-D Tensor, the output shape as if keepdims were set to True.</returns>
      class function reduced_shape(input_shape: TFTensor; axes: TFTensor): TFTensor; static;
      /// <summary>
      /// Computes the reciprocal of x element-wise.
      /// </summary>
      /// <param name="x"></param>
      /// <param name="name"></param>
      /// <returns></returns>
      class function reciprocal(x : TFTensor; name : string = ''): TFTensor; static;
      class function realdiv(x : TFTensor; y: TFTensor; name : string = ''): TFTensor; static;
      /// <summary>
      /// Computes the sum along segments of a tensor.
      /// </summary>
      /// <param name="data"></param>
      /// <param name="segment_ids"></param>
      /// <param name="num_segments"></param>
      /// <param name="name"></param>
      /// <returns></returns>
      class function unsorted_segment_sum(data: TFTensor; segment_ids: TFTensor; num_segments: TFTensor; name : string = ''): TFTensor; static;
      /// <summary>
      /// Casts a tensor to a new type.
      /// </summary>
      /// <param name="x"></param>
      /// <param name="dtype"></param>
      /// <param name="name"></param>
      /// <returns>A `Tensor` or `SparseTensor` or `IndexedSlices` with same shape as `x` and same type as `dtype`.</returns>
      class function __case__(x : TFTensor; dtype: TF_DataType; name : string = ''): TFTensor; static;
      /// <summary>
      /// Computes reciprocal of square root of x element-wise.
      /// </summary>
      /// <param name="x"></param>
      /// <param name="name"></param>
      /// <returns></returns>
      class function rsqrt(x : TFTensor; name : string = ''): TFTensor; static;
      class function floor(x : TFTensor; name : string = ''): TFTensor; static;
      class function floordiv(x : TFTensor; y: TFTensor; name : string = ''): TFTensor; static;
      class function minimum<Tx, Ty>(x: Tx; y: Ty; name : string = ''): TFTensor; static;
      class function maximum<Tx, Ty>(x: Tx; y: Ty; name : string = ''): TFTensor; static;
      class function batch_matmul(x : TFTensor; y: TFTensor; adj_x: Boolean = false; adj_y: Boolean = false; name : string = ''): TFTensor; static;
      class function bincount(arr: TFTensor; weights : TFTensor = nil; minlength : TFTensor= nil; maxlength: TFTensor = nil; dtype: TF_DataType = TF_INT32; name: string = ''; axis: PTFShape = nil; binary_output: Boolean = false): TFTensor; static;
      class function tanh(x : TFTensor; name : string = ''): TFTensor; static;
      class function tensordot(a: TFTensor; b: TFTensor; axes: TNDArray; name : string = ''): TFTensor; static;
      class function _tensordot_axes(a: TFTensor; axes: TNDArray) : Tuple< TArray<Integer>,TArray<Integer> >; static;
      class function _tensordot_reshape(a: TFTensor; axes: TArray<Integer>; flipped: Boolean = false) : Tuple< TFTensor, TArray<Integer>,TArray<Integer> >; static;

  end;

implementation
         uses Tensorflow,
              TensorFlow.Tensor,
              TensorFlow.Constant_op,
              TensorFlow.Ops,
              Tensorflow.gen_array_ops,
              TensorFlow.gen_math_ops,
              Tensorflow.array_ops,
              Tensorflow.NameScope,
              Tensorflow.Utils,
              TensorFlow.Framework;

{ math_ops }

class function math_ops.digamma(x: TFTensor; name: string): TFTensor;
begin
    Result := gen_math_ops.digamma(x, name);
end;

class function math_ops.&div(x, y: TFTensor; name: string): TFTensor;
begin
    var vValues : TArray<TValue> := [x, y];
    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'div', @vValues),
                                          function(v1: TNameScope): TFTensor
                                            begin
                                                x := Tops.convert_to_tensor(x, DtInvalid, 'x');
                                                y := Tops.convert_to_tensor(y, TdTypes.as_base_dtype(x.dtype), 'y');
                                                var x_dtype := TdTypes.as_base_dtype(x.dtype);
                                                var y_dtype := TdTypes.as_base_dtype(y.dtype);
                                                if x_dtype <> y_dtype then
                                                   raise Exception.Create('x and y must have the same dtype, got {x_dtype} != {y_dtype}');

                                                if ( TDtypes.is_floating(x_dtype) ) or ( TDtypes.is_complex(x_dtype) ) then  Result := gen_math_ops.real_div( x, y, name)
                                                else                                                                         Result := gen_math_ops.floor_div(x, y, name);
                                            end );
end;

class function math_ops.div_no_nan(x, y: TFTensor; name: string): TFTensor;
begin
    var vValues : TArray<TValue> := [x, y];
    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'div_no_nan', @vValues),
                                          function(v1: TNameScope): TFTensor
                                            begin
                                                x := Tops.convert_to_tensor(x, DtInvalid, 'x');
                                                y := Tops.convert_to_tensor(y, TdTypes.as_base_dtype(x.dtype), 'y');
                                                var x_dtype := TdTypes.as_base_dtype(x.dtype);
                                                var y_dtype := TdTypes.as_base_dtype(y.dtype);
                                                if x_dtype <> y_dtype then
                                                   raise Exception.Create('x and y must have the same dtype, got {x_dtype} != {y_dtype}');
                                                Result := gen_math_ops.div_no_nan(x, y, name);
                                            end );
end;

class function math_ops.einsum(equation: string; inputs: TFTensors; name: string): TFTensor;
begin
    var a := inputs.ToArray;
    var vValues : TArray<TValue> := [];
    for var i := 0 to Length(a) - 1 do
       vValues := vValues +[ a[i] ];

    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'einsum', @inputs),
                                function(v1: TNameScope): TFTensor
                                  begin
                                      var Args := ExecuteOpArgs.Create(vValues);
                                      Args.GetGradientAttrs :=  function(op: TFOperation): TArray<TParameter>
                                             begin
                                                 Result := [];
                                                 var pParam : TParameter;
                                                 pParam.sNome := 'equation' ;
                                                 pParam.vValue:= op.get_attr('equation');
                                                 Result := Result + [ pParam ] ;

                                                 pParam.sNome := 'N' ;
                                                 pParam.vValue:= op.get_attr('N');
                                                 Result := Result + [ pParam ] ;

                                                 pParam.sNome := 'T' ;
                                                 pParam.vValue:= op.get_attr('T');
                                                 Result := Result + [ pParam ] ;
                                             end;
                                      Args.SetAttributes(['equation',equation]);
                                      Result := tf.Context.ExecuteOp('Einsum', name, Args).FirstOrDefault(nil);
                                  end );
end;

class function math_ops.equal<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
    Result := gen_math_ops.equal(x, y, True, name);
end;

class function math_ops.erf(x: TFTensor; name: string): TFTensor;
begin
    Result := tf.Context.ExecuteOp('Erf', name, ExecuteOpArgs.Create([x])).FirstOrDefault(nil)
end;

class function math_ops.floor(x: TFTensor; name: string): TFTensor;
begin
    Result := tf.Context.ExecuteOp('Floor', name, ExecuteOpArgs.Create([x])).FirstOrDefault(nil)
end;

class function math_ops.floordiv(x, y: TFTensor; name: string): TFTensor;
begin
    var vValues : TArray<TValue> := [x, y];

    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'floordiv', @vValues),
                                function(v1: TNameScope): TFTensor
                                  begin
                                      Result := gen_math_ops.floor_div(x, y, v1.ToString);
                                  end );
end;

class function math_ops.greater_equal<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
    Result := gen_math_ops.greater_equal<Tx, Ty>(x, y, name);
end;

class function math_ops.lgamma(x: TFTensor; name: string): TFTensor;
begin
    Result :=  gen_math_ops.lgamma(x, name);
end;

class function math_ops.linspace(start, stop: TFTensor; num: Integer; name: string; axis: Integer): TFTensor;
begin
    var vValues : TArray<TValue> := [start, stop];

    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'linspace', @vValues),
                                function(v1: TNameScope): TFTensor
                                  begin
                                      var num_int_tensor := array_ops.constant(num);
                                      var num_tensor     := array_ops.constant(num, start.dtype);

                                      var broadcast_shape := array_ops.broadcast_dynamic_shape(array_ops.shape(start), array_ops.shape(stop));
                                      start               := gen_array_ops.broadcast_to(start, broadcast_shape);
                                      stop                := gen_array_ops.broadcast_to(stop,  broadcast_shape);

                                      var expanded_start := array_ops.expand_dims(start, axis);
                                      var expanded_stop  := array_ops.expand_dims(stop,  axis);

                                      var shape := array_ops.shape(expanded_start);
                                      var ndims := array_ops.shape(shape)[0];

                                      var axis_tensor := array_ops.where_v2(constant_op.constant(axis >= 0), TObject(axis), TTensor(ndims) + axis);

                                      // The purpose is to avoid having negative values when repeating.
                                      var num_fill := gen_math_ops.maximum( TTensor(num_int_tensor) - 2, 0);
                                      var n_steps  := gen_math_ops.maximum( TTensor(num_int_tensor) - 1, 1);
                                      var delta : TFTensor   := TTensor(TTensor(expanded_stop) - expanded_start) / cast(n_steps, expanded_stop.dtype);

                                      var range_end          := array_ops.where_v2( TTensor(num_int_tensor) >= 0, n_steps, TObject(-1));
                                      var range_end_value : TValue := range_end;
                                      var desired_range      := cast( range(1,@range_end_value, nil,Tdtypes.cint64), delta.dtype );
                                      var mask               := gen_math_ops.equal(axis_tensor, range(ndims));
                                      var desired_range_shape:= array_ops.where_v2(mask, num_fill, TObject(1));
                                      desired_range          := array_ops.reshape(desired_range, desired_range_shape);
                                      var res                := TTensor(TTensor(expanded_start) + delta) * desired_range;

                                      // Add the start and endpoints to the result, and slice out the desired
                                      // portion.
                                      var all_tensors : TArray<TFTensor> := [ expanded_start, res, expanded_stop ];
                                      var concatenated                   := array_ops.concat(all_tensors, axis);
                                      var _begin                         := array_ops.zeros_like(shape);
                                      var size                           := array_ops.where_v2(mask, num_int_tensor, shape);

                                      Result := array_ops.slice(concatenated, _begin, size);
                                  end );
end;

class function math_ops.log(x: TFTensor; name: string): TFTensor;
begin
    Result := gen_math_ops.log(x, name);
end;

class function math_ops.logical_and(x, y: TFTensor; name: string): TFTensor;
begin
    Result := gen_math_ops.logical_and(x, y, name);
end;

class function math_ops.not_equal<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
    Result := gen_math_ops.not_equal(x, y, name)
end;

class function math_ops.pow<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
    var vX := TValue.From<Tx>(x);
    var vY := TValue.From<Ty>(y);
    var newVal : TValue := TValue.From<TArray<TValue>>([vX,vY]);

    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'Pow', @newVal),
                  function(v1: TNameScope): TFTensor
                    begin
                        name := v1.ToString;

                        var x_tensor := Tops.convert_to_tensor(vX, DtInvalid, 'x');
                        var y_tensor := Tops.convert_to_tensor(vY, Tdtypes.as_base_dtype(x_tensor.dtype), 'y');

                        Result := tf.Context.ExecuteOp('Pow', name, ExecuteOpArgs.Create([x_tensor, y_tensor])).FirstOrDefault(nil)
                    end );
end;

class function math_ops.range(start: TValue; limit: PValue; delta: PValue; dtype: TF_DataType; name: string): TFTensor;
begin
    if limit = nil then
    begin
        limit := @start;
        start := 0;
    end;
    var dtype1 : TF_DataType;
    if not (dtype = dtinvalid) then  dtype1 := dtype
    else                             dtype1 := TUtils.GetdataType(limit^);

    var newVal : TValue := TValue.From<TArray<TValue>>([start, limit^,delta^]);;
    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'Range', @newVal),
                                          function(v1: TNameScope): TFTensor
                                            begin
                                                name := v1.ToString;

                                                var start1 := Tops.convert_to_tensor(start, dtype1, 'start');
                                                var limit1 := Tops.convert_to_tensor(limit^, dtype1, 'limit');
                                                var v : TValue;
                                                if delta = nil   then v := 1
                                                else                  v := delta^;
                                                var delta1 := Tops.convert_to_tensor(v, dtype1, 'delta');
                                                Result := gen_math_ops.range(start1, limit1, delta1, name);
                                            end );
end;

class function math_ops.real(input: TFTensor; name: string): TFTensor;
begin
    var newVal : TValue := TValue.From<TArray<TValue>>([input]);;
    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'Real', @newVal),
                                          function(v1: TNameScope): TFTensor
                                            begin
                                               input := Tops.convert_to_tensor(input, DtInvalid, 'input');
                                               if TDtypes.is_complex(input.dtype) then
                                               begin
                                                   var real_dtype := TDtypes.real_dtype(input.dtype);
                                                   Result := real(input, v1.ToString);
                                               end else
                                               begin
                                                   Result := input;
                                               end;
                                            end );
end;

class function math_ops.realdiv(x, y: TFTensor; name: string): TFTensor;
begin
    Result := gen_math_ops.real_div(x, y, name);
end;

class function math_ops.reciprocal(x: TFTensor; name: string): TFTensor;
begin
    Result := gen_math_ops.reciprocal(x, name);
end;

class function math_ops.reduced_shape(input_shape, axes: TFTensor): TFTensor;
begin

end;

class function math_ops.reduce_all(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.reduce_any(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.reduce_logsumexp(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.reduce_max(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.reduce_mean(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string; reduction_indices: PInteger): TFTensor;
begin

end;

class function math_ops.reduce_min(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.reduce_prod(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.reduce_std(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.reduce_sum(input_tensor, axis: TFTensor; keepdims: Boolean; name: string): TFTensor;
begin
    var r  := _ReductionDims(input_tensor, axis);
    var m  := gen_math_ops._sum(input_tensor, r, keepdims, name);
    Result := _may_reduce_to_scalar(keepdims, axis, m);
end;

class function math_ops.reduce_variance(input_tensor: TFTensor; axis: TAxis; keepdims: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.Round(x: TFTensor; name: string): TFTensor;
begin

end;

class function math_ops.rsqrt(x: TFTensor; name: string): TFTensor;
begin
   Result := gen_math_ops.rsqrt(x, name);
end;

class function math_ops.saturate_cast(value: TFTensor; dtype: TF_DataType; name: string): TFTensor;
begin

end;

class function math_ops.scalar_mul<Tscale, Tx>(scale: Tscale; x: Tx; name: string): TFTensor;
begin

end;

class function math_ops.sigmoid<T>(x: T; name: string): TFTensor;
begin

end;

class function math_ops.sign<T>(x: T; name: string): TFTensor;
begin
   Result := gen_math_ops.sign(x, name);
end;

class function math_ops.sin(x: TFTensor; name: string): TFTensor;
begin
   Result := tf.Context.ExecuteOp('Sin', name, ExecuteOpArgs.Create([x])).FirstOrDefault(nil)
end;

class function math_ops.sqrt(x: TFTensor; name: string): TFTensor;
begin
    Result := gen_math_ops.sqrt(x, name);
end;

class function math_ops.square(x: TFTensor; name: string): TFTensor;
begin
   Result := gen_math_ops.square(x, name);
end;

class function math_ops.square_difference(x, y: TFTensor; name: string): TFTensor;
begin
   Result := gen_math_ops.squared_difference(x, y);
end;

class function math_ops.subtract<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
    Result := gen_math_ops.sub(x, y, name);
end;

class function math_ops._may_reduce_to_scalar(keepdims: Boolean; axis: PAxis; _output: TFTensor) : TFTensor;
begin
    Result := nil;
    var dims: TArray<TF_int64_t> := [];
    if ( not common_shapes.has_fully_defined_shape(_output) ) and ( not keepdims) and (axis = nil) and ( _output.shape = TFShape.Create(dims) ) then
            Result := _output;
end;

class function math_ops._may_reduce_to_scalar(keepdims: Boolean; axis: TFTensor; _output: TFTensor) : TFTensor;
begin
    Result := nil;
    var dims: TArray<TF_int64_t> := [];
    if ( not common_shapes.has_fully_defined_shape(_output) ) and ( not keepdims) and (axis = nil) and ( _output.shape = TFShape.Create(dims) ) then
            Result := _output;
end;

class function math_ops._ReductionDims(x, axis: TFTensor): TFTensor;
begin
    if axis <> nil then
    begin
        Result := axis;
    end else
    begin
        var rank := array_ops.rank(x);
        var rank_value : TValue := rank;
        var r1_value   : TValue := 1;
        Result := range(0, @rank_value, @r1_value);
    end;
end;


class function math_ops.matmul(a, b: TFTensor; transpose_a, transpose_b, adjoint_a, adjoint_b, a_is_sparse, b_is_sparse: Boolean;
  name: string): TFTensor;
begin
    var vValues : TArray<TValue>;
    vValues := vValues + [ a ];
    vValues := vValues + [ b ];
    var newVal : TValue := TValue.From<TArray<TValue>>(vValues);;
    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'MatMul', @newVal),
                                          function(v1: TNameScope): TFTensor
                                            begin
                                                name := v1.ToString;

                                                if (transpose_a) and (adjoint_a) then
                                                    raise Exception.Create('Only one of transpose_a and adjoint_a can be True.');
                                                if (transpose_b) and (adjoint_b) then
                                                    raise Exception.Create('Only one of transpose_b and adjoint_b can be True.');
                                                if adjoint_a then
                                                begin
                                                    a := conj(a);
                                                    transpose_a := true;
                                                end;
                                                if adjoint_b then
                                                begin
                                                    b := conj(b);
                                                    transpose_b := true;
                                                end;
                                                result := gen_math_ops.mat_mul(a, b, transpose_a, transpose_b, name);
                                            end );
end;

class function math_ops.matmul(a, b: TFTensor; name: string): TFTensor;
begin
    Result := matmul(a,b,False,False,False,False,False,False,name);
end;

class function math_ops.maximum<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
   Result := gen_math_ops.maximum(x, y, name);
end;

class function math_ops.minimum<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
   Result := gen_math_ops.minimum(x, y, name);
end;

class function math_ops.multiply(x, y: TFTensor; name: string): TFTensor;
begin
    Result := tf.Context.ExecuteOp('Mul', name, ExecuteOpArgs.Create([x, y])).FirstOrDefault(nil)
end;

class function math_ops.multiply<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
   Result := gen_math_ops.mul(x, y, name);
end;

class function math_ops.mul_no_nan<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
    Result := gen_math_ops.mul_no_nan(x, y, name);
end;

class function math_ops.tanh(x: TFTensor; name: string): TFTensor;
begin
   Result := gen_math_ops.tanh(x, name);
end;

class function math_ops.tensordot(a, b: TFTensor; axes: TNDArray; name: string): TFTensor;
begin

end;

class function math_ops.to_int32(x: TFTensor; name: string): TFTensor;
begin

end;

class function math_ops.truediv(x, y: TFTensor; name: string): TFTensor;
begin
    Result := _truediv_python3(x, y, name);
end;

class function math_ops.unsorted_segment_sum(data, segment_ids, num_segments: TFTensor; name: string): TFTensor;
begin
    Result := gen_math_ops.unsorted_segment_sum(data, segment_ids, num_segments, name);
end;

class function math_ops._tensordot_axes(a: TFTensor; axes: TNDArray): Tuple<TArray<Integer>, TArray<Integer>>;
begin

end;

class function math_ops._tensordot_reshape(a: TFTensor; axes: TArray<Integer>; flipped: Boolean): Tuple<TFTensor, TArray<Integer>, TArray<Integer>>;
begin

end;

class function math_ops._truediv_python3(x, y: TFTensor; name: string): TFTensor;
begin
    var vValues : TArray<TValue>;
    vValues := vValues + [ x ];
    vValues := vValues + [ y ];
    var newVal : TValue := TValue.From<TArray<TValue>>(vValues);;
    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'truediv', @newVal),
                                          function(v1: TNameScope): TFTensor
                                            begin
                                                name := v1.ToString;
                                                var x_dtype := Tdtypes.as_base_dtype(x.Dtype);
                                                var y_dtype := Tdtypes.as_base_dtype(y.Dtype);
                                                if x_dtype <> y_dtype then
                                                   raise Exception.Create('x and y must have the same dtype, got {x_dtype} != {y_dtype}');
                                                var dtype : TF_DataType;
                                                case x_dtype of
                                                  TF_DataType.TF_UINT8  : dtype := TF_DataType.TF_FLOAT;
                                                  TF_DataType.TF_INT8   : dtype := TF_DataType.TF_FLOAT;
                                                  TF_DataType.TF_INT16  : dtype := TF_DataType.TF_FLOAT;
                                                  TF_DataType.TF_UINT16 : dtype := TF_DataType.TF_FLOAT;
                                                  TF_DataType.TF_INT32  : dtype := TF_DataType.TF_DOUBLE;
                                                  TF_DataType.TF_INT64  : dtype := TF_DataType.TF_DOUBLE;
                                                else
                                                  dtype := x_dtype;
                                                end;
                                                x := cast(x, dtype);
                                                y := cast(y, dtype);
                                                Result := gen_math_ops.real_div(x, y, name);
                                            end );
end;

class function math_ops.abs(x: TFTensor; name: string): TFTensor;
begin

end;

class function math_ops.__case__(x: TFTensor; dtype: TF_DataType; name: string): TFTensor;
begin

end;

class function math_ops.add<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
    Result := gen_math_ops.add(x, y, name);
end;

class function math_ops.add_n(inputs: TArray<TFTensor>; name: string): TFTensor;
begin

end;

class function math_ops.add_v2(x, y: TFTensor; name: string): TFTensor;
begin
    Result := tf.Context.ExecuteOp('AddV2', name, ExecuteOpArgs.Create([x, y])).FirstOrDefault(nil)
end;

class function math_ops.add_v2<Tx, Ty>(x: Tx; y: Ty; name: string): TFTensor;
begin
   Result := gen_math_ops.add_v2(x, y, name);
end;

class function math_ops.argmax(input: TFTensor; dimension: TAxis; output_type: TF_DataType; name: string): TFTensor;
begin
   Result := gen_math_ops.arg_max(input, dimension, output_type, name);
end;

class function math_ops.batch_matmul(x, y: TFTensor; adj_x, adj_y: Boolean; name: string): TFTensor;
begin

end;

class function math_ops.bincount(arr, weights, minlength, maxlength: TFTensor; dtype: TF_DataType; name: string; axis: PTFShape; binary_output: Boolean): TFTensor;
begin

end;

class function math_ops.cast(x: TFTensor; dtype: TF_DataType; name: string): TFTensor;
begin
    var base_type := Tdtypes.as_base_dtype(dtype);
    if base_type = x.dtype then
        Exit(x);

    var vvalue := TValue.From<TFTensor>(x);
    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'Cast', @vvalue),
                                          function(v1: TNameScope): TFTensor
                                            begin
                                                name := string(v1.ToString);
                                                if Tdtypes.as_base_dtype(x.dtype) <> base_type then
                                                    x := gen_math_ops.cast(x, base_type, name);
                                                Result := x;
                                            end );
end;

class function math_ops.cast(x: ResourceVariable; dtype: TF_DataType; name: string): ResourceVariable;
begin

end;

class function math_ops.cast(x: IVariableV1; dtype: TF_DataType; name: string): TFTensor;
begin

end;

class function math_ops.conj(x: TFTensor; name: string): TFTensor;
begin
    var dt := x.dtype;
    if (Tdtypes.is_floating(dt)) or (Tdtypes.is_integer(dt))then
        Exit( x );

    var vValues : TValue := x;

    Result := TUtils.tf_with<TNameScope,TFTensor>( TOps.name_scope(name, 'Conj', @vValues),
                                          function(v1: TNameScope): TFTensor
                                            begin
                                                Result :=  v1._values.AsType<TFTensor>;
                                            end );
end;

class function math_ops.cos(x: TFTensor; name: string): TFTensor;
begin
   tf.Context.ExecuteOp('Cos', name, ExecuteOpArgs.Create([x])).FirstOrDefault(nil)
end;

class function math_ops.cumsum<T>(x: TFTensor; axis: T; exclusive, reverse: Boolean; name: string): TFTensor;
begin

end;

class function math_ops._may_reduce_to_scalar(keepdims: Boolean; axis: Integer; _output: TFTensor): TFTensor;
begin

end;

class function math_ops._ReductionDims(x: TFTensor; axis: TAxis): TFTensor;
begin

end;

end.
